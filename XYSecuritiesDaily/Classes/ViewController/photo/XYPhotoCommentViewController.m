//
//  XYPhotoCommentViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-24.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPhotoCommentViewController.h"

@interface XYPhotoCommentViewController ()

@end

@implementation XYPhotoCommentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * btn = [self.xToolBar.items objectAtIndex:1];
    btn.hidden = NO;
    [btn addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.xNavigationBar.frame = CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT+40);
    self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT+40, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    self.tableView.frame = self.xView.bounds;
    
    [self getPhotosComment];

}

#pragma mark - 点击
///点击评论
- (void)clickCommentButton:(UIButton*)btn {
    XYPCEditViewController * vc = [[XYPCEditViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.image = self.image;
    vc.delegate = self;
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XYPCEditViewController * vc = [[XYPCEditViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.image = self.image;
    vc.delegate = self;
    vc.comment = [self.dataArray objectAtIndex:indexPath.row];
    [self presentViewController:nav animated:NO completion:nil];
}




#pragma mark - 解析
///获取跟帖
- (void)getPhotosComment {
    if (self.netStatus) {
        [self getNetPhotosComment];
    }else {
        [self getSqlPhotosCommentWithNetStatus:NO];
    }
}

//网络获取跟帖
- (void)getNetPhotosComment {
    self.isLoading = YES;
    NSString * page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSDictionary * parameters = @{@"mode":@"pad_2.0",
                                  @"id":self.image.idString,
                                  @"page":page};
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * comment_list = [[[root elementsForName:@"comment_list"] firstObject] elementsForName:@"comment"];
        if (self.pageIndex == 1) {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"from_id=\"%@\" and type=\"%@\" and is_my=\"0\"",self.image.idString,MDCOMMENT_TYPE_PHOTOS]];
        }else {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"from_id=\"%@\" and page=\"%@\" and type=\"%@\" and is_my=\"0\"",self.image.idString,page,MDCOMMENT_TYPE_PHOTOS]];
        }
        
        for (int i=0; i<comment_list.count; i++) {
            GDataXMLElement * element = [comment_list objectAtIndex:i];
            MDComment * comment = [[MDComment alloc] initWithElement:element];
            [comment insertWithFrom_id:self.image.idString
                                  type:MDCOMMENT_TYPE_PHOTOS
                                  is_my:MDCOMMENT_TYPE_NOTMY
                                  page:page];
            if (![self.sqlManager insertItem:comment]) {
                NSLog(@"图集评论插入失败");
            }
            
        }
        NSString * allpage = [[[root elementsForName:@"allpage"] firstObject] stringValue];
        if (allpage) {
            self.pageCount = [allpage intValue];
        }
        
        [self getSqlPhotosCommentWithNetStatus:YES];
    } falid:^(NSString *errorMsg) {
        [self getSqlPhotosCommentWithNetStatus:NO];
    }];

}
- (void)getSqlPhotosCommentWithNetStatus:(BOOL)status {
    NSString * where = [NSString stringWithFormat:@"from_id=\"%@\" and page=\"%d\" and type=\"%@\"  and is_my=\"0\"",self.image.idString,self.pageIndex,MDCOMMENT_TYPE_PHOTOS];
    NSArray * arr = [self.sqlManager selectTableName:TABLE_Comment parameters:@[@"*"] where:where];
    
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (arr.count > 0) {
        [self.dataArray addObjectsFromArray:arr];
        
        if (!status) {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_CACHE duration:1];
        }
    }else {
        if (status) {
            if (self.pageIndex == 1) {//刷新
                [SVProgressHUD showErrorWithStatus:@"没有最新跟帖" duration:1];
            }else {//加载更多
                [SVProgressHUD showErrorWithStatus:@"没有更多跟帖" duration:1];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1];
        }
    }
    
    [self reloadData];
}



#pragma mark - tableViewDelgate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDComment * comment = [self.dataArray objectAtIndex:indexPath.row];
    BOOL       c = NO;
    if (comment.parent_content || comment.parent_user_name) {
        c = YES;
    }
    return [XYPhotosCommentCell heightWithAString:comment.content isHasFromUser:c BString:comment.parent_content]+10;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPhotosCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[XYPhotosCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    [cell setComment:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}








#pragma mark - EGO
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshHeader) {//刷新
        self.pageIndex = 1;
        [self getPhotosComment];
    }else {//加载更多
        if (self.pageIndex+1<=self.pageCount) {
            self.pageIndex++;
            [self getPhotosComment];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"没有更多的跟帖了" duration:1.5f];
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    }
}


#pragma mark - CommentDelegate
- (void)commentDidFinish {
    [self getPhotosComment];
}

@end
