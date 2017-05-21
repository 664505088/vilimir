//
//  XYNewsCommentViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsCommentViewController.h"

@interface XYNewsCommentViewController ()

@end

@implementation XYNewsCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton * btn = [self.xToolBar.items objectAtIndex:1];
    btn.hidden = NO;
    [btn addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.xNavigationBar.frame = CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT+40);
    self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT+40, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    self.tableView.frame = self.xView.bounds;
    
    [self getNewsComment];
}

#pragma mark - 点击
///点击跟帖
- (void)clickCommentButton:(UIButton*)btn {
    XYNCEditViewController * vc = [[XYNCEditViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.news = self.news;
//    vc.delegate = self;
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYNCEditViewController * vc = [[XYNCEditViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.news = self.news;
//    vc.delegate = self;
    vc.comment = [self.dataArray objectAtIndex:indexPath.row];
    [self presentViewController:nav animated:NO completion:nil];
}




#pragma mark - 解析
///获取跟帖

- (void)getNewsComment {
    if (self.netStatus) {
        [self getNetNewsComment];
    }else {
        [self getSqlNewsCommentWithNetStatus:NO];
    }
}

- (void)getNetNewsComment {
    self.isLoading = YES;
    [SVProgressHUD showWithStatus:@"获取列表中..."];
    NSString * page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSDictionary * parameters = @{@"mode":@"pad_1.7",
                                  @"id":self.news.idString,
                                  @"page":page};


    [[RequestService defaultService] getUrl:HOST parameters:parameters success:^(NSString *stringData) {
        NSLog(@"%@",stringData);
    } falid:nil];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * comment_list = [[[root elementsForName:@"comment_list"] firstObject] elementsForName:@"comment"];
        
        if (self.pageIndex == 1) {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"from_id=\"%@\" and type=\"%@\" and is_my=\"0\"",self.news.idString,MDCOMMENT_TYPE_NEWS]];
        }else {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"from_id=\"%@\" and page=\"%@\" and type=\"%@\" and is_my=\"0\"",self.news.idString,page,MDCOMMENT_TYPE_NEWS]];
        }
        
        if (self.pageIndex == 1) {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"idString=\"%@\"",self.news.idString]];
        }

        for (int i=0; i<comment_list.count; i++) {
            GDataXMLElement * element = [comment_list objectAtIndex:i];
            MDComment * comment = [[MDComment alloc] initWithElement:element];
            [comment insertWithFrom_id:self.news.idString
                                  type:MDCOMMENT_TYPE_NEWS
                                  is_my:MDCOMMENT_TYPE_NOTMY
                                  page:page];
            
            if (![self.sqlManager insertItem:comment]) {
                NSLog(@"新闻跟帖插入失败 %@",[self.sqlManager.dataBase lastError]);
            }
        }
        NSString * allpage = [[[root elementsForName:@"allpage"] firstObject] stringValue];
        if (allpage) {
            self.pageCount = [allpage intValue];
        }
        
        [self getSqlNewsCommentWithNetStatus:YES];
    } falid:^(NSString *errorMsg) {
        NSLog(@"跟帖列表获取失败 %@",errorMsg);
        [self getSqlNewsCommentWithNetStatus:NO];
    }];
}

- (void)getSqlNewsCommentWithNetStatus:(BOOL)status {
    
    NSString * where = [NSString stringWithFormat:@"from_id=\"%@\" and page=\"%d\" and type=\"%@\" and is_my=\"0\"",self.news.idString,self.pageIndex,MDCOMMENT_TYPE_NEWS];
    NSArray * arr = [self.sqlManager selectTableName:TABLE_Comment parameters:@[@"*"] where:where];
    NSLog(@"%@",arr);
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (arr.count > 0) {
        [self.dataArray addObjectsFromArray:arr];
        if (!status) {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_CACHE duration:1];
        }else {
            [SVProgressHUD dismiss];
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
    
    if (self.commentCountLabel && self.dataArray.count>0) {
        self.commentCountLabel.text = [NSString stringWithFormat:@"%d跟帖",(int)self.dataArray.count];
        CGSize size = [self.commentCountLabel.text sizeWithFont:self.commentCountLabel.font constrainedToSize:CGSizeMake(1000, 30)];
        CGRect frame = self.commentCountLabel.frame;
        frame.size.width = size.width+5;
        frame.size.height = size.height+5;
        frame.origin.x = H_WIDTH-45-size.width;
        self.commentCountLabel.frame = frame;
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
    return [XYNewsCommentCell heightWithAString:comment.content isHasFromUser:c BString:comment.parent_content]+10;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYNewsCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[XYNewsCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    [cell setComment:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}








#pragma mark - EGO
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshHeader) {//刷新
        self.pageIndex = 1;
        [self getNewsComment];
    }else {//加载更多
        if (self.pageIndex+1<=self.pageCount) {
            self.pageIndex++;
            [self getNewsComment];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"没有更多的跟帖了" duration:1.5f];
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    }
}



#pragma mark - CommentDelegate
- (void)commentDidFinish {
    [self getNewsComment];
}
@end
