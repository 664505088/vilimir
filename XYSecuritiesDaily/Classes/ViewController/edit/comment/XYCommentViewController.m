//
//  XYCommentViewController.m
//  XYSecuritiesDaily
//  我的跟帖
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYCommentViewController.h"

@interface XYCommentViewController ()

@end

@implementation XYCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xNavigationBar.frame = CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT+40);
    self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT+40, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    self.tableView.frame = self.xView.bounds;
    
    //我 的 跟 帖 标题
    UILabel * myCollectLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 15+STATUS_HEIGHT, 180, 42) Text:@"我 的 跟 帖" Font:30];
    [self.xNavigationBar addSubview:myCollectLabel];
    
    [self getMyConmmentList];
}

#pragma mark - 点击






#pragma mark - 解析
- (void)getMyConmmentList {
    self.isLoading = YES;
    NSString * page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSDictionary * parameters = @{@"mode":@"pad_1.6",
                                  @"id":self.editManager.user.userId,
                                  @"page":page};
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {

        
        //获取总页数
        self.pageCount = [[[[root elementsForName:@"allpage"] firstObject] stringValue] intValue];
        
        //数据库操作
        NSArray * comment_list = [[[root elementsForName:@"comment_list"] firstObject] elementsForName:@"comment"];
        
        ///删除数据库内容
        if (comment_list.count > 0 && self.pageIndex== 1) {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"my_user_id=\"%@\" and is_my=\"%@\"",self.editManager.user.userId,MDCOMMENT_TYPE_MY]];
        }else {
            [self.sqlManager deleteFromTableName:TABLE_Comment where:[NSString stringWithFormat:@"my_user_id=\"%@\" and is_my=\"%@\" and page=\"%@\"",self.editManager.user.userId,MDCOMMENT_TYPE_MY,page]];
        }

        //插入数据库
        for (int i=0; i<comment_list.count; i++) {
            GDataXMLElement * element = [comment_list objectAtIndex:i];
            MDComment * comment = [[MDComment alloc] initWithElement:element];
            NSString * from_id = [[[element elementsForName:@"newsId"] firstObject] stringValue];
            NSString * type = [[[element elementsForName:@"type"] firstObject] stringValue];
            type = [type isEqualToString:@"0"]?MDCOMMENT_TYPE_NEWS:MDCOMMENT_TYPE_PHOTOS;
            [comment insertWithFrom_id:from_id
                                  type:type
                                 is_my:MDCOMMENT_TYPE_MY
                                  page:page];
            comment.my_user_id = self.editManager.user.userId;
            //如果不是已删除状态
            if (![comment.status isEqualToString:@"3"]) {
                if (![self.sqlManager insertItem:comment]) {
                    NSLog(@"我的跟帖插入数据库失败:%@",[self.sqlManager.dataBase lastError]);
                }
            }
        }
        [self getSqlMyComment];
        
    } falid:^(NSString *errorMsg) {
        [self getSqlMyComment];
    }];

}

- (void)getSqlMyComment {
    NSString * where = [NSString stringWithFormat:@"my_user_id=\"%@\" and is_my=\"%@\" and page=\"%d\"",self.editManager.user.userId,MDCOMMENT_TYPE_MY,self.pageIndex];
    NSArray * arr = [self.sqlManager selectTableName:TABLE_Comment parameters:@[@"*"] where:where];
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (arr.count > 0) {
        self.pageIndex++;
        [self.dataArray addObjectsFromArray:arr];
    }else {
        if (self.pageIndex == 1) {//刷新
            [SVProgressHUD showErrorWithStatus:@"没有最新数据" duration:1];
        }else {//加载更多
            [SVProgressHUD showErrorWithStatus:@"没有更多数据了" duration:1];
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
    
    return [XYCommentCell heightWithDescript:comment.content
                                       title:comment.news_title
                               isHasFromUser:c
                                   from_user:comment.parent_user_name
                               from_descript:comment.parent_content];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[XYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    [cell setComment:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MDComment * comment = [self.dataArray objectAtIndex:indexPath.row];
    //如果是新闻
    if ([comment.type isEqualToString:MDCOMMENT_TYPE_NEWS]) {
        if (self.netStatus) {
            if (comment.from_id && comment.column_id) {
                
                XYDetailViewController * vc = [[XYDetailViewController alloc] init];
                MDNew * news = [[MDNew alloc] init];
                
                news.idString = comment.from_id;
                news.column_id = comment.column_id;
                vc.news = news;
                vc.hideEditItem = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                [SVProgressHUD showErrorWithStatus:@"该新闻已被删除" duration:1.5f];
                NSLog(@"from_id或column_id 值为null,无法找到该新闻");
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"请检查网络" duration:1.5f];
        }
    }
    //如果是图集
    else if ([comment.type isEqualToString:MDCOMMENT_TYPE_PHOTOS]) {
        XYPhotosDetailViewController * vc = [[XYPhotosDetailViewController alloc] init];
        MDImage * image = [[MDImage alloc] init];
        image.idString = comment.from_id;
        vc.image = image;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - EGO
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshHeader) {//刷新
        self.pageIndex = 1;
    }
    if (self.pageIndex > 0 && self.pageIndex < self.pageCount) {
        [self getMyConmmentList];
    }
    else {
        self.isLoading = YES;
        [self performSelector:@selector(reloadData) withObject:nil afterDelay:1];
    }
}
@end
