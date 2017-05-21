//
//  XYMessageViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYMessageViewController.h"

@interface XYMessageViewController ()

@end

@implementation XYMessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.xNavigationBar.frame = CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT+40);
    self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT+40, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    self.tableView.frame = self.xView.bounds;

    //我的收藏 标题
    UILabel * myCollectLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 15+STATUS_HEIGHT, 180, 42) Text:@"我 的 消 息" Font:30];
    [self.xNavigationBar addSubview:myCollectLabel];
    
    
    
    

    [self getMyMessage];
}

#pragma mark - 点击





#pragma mark - 解析
///获取消息列表(获取网络->选择net/sql)
- (void)getMyMessage {
    if (self.netStatus) {
        [self getNetMyMessage];
    }else {
        [self getSqlMyMessageWithNetStatus:NO];
    }
}



///有网络,获取网络数据
- (void)getNetMyMessage {
    self.isLoading = YES;
    NSString * page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSDictionary * parameters = @{@"mode":@"pad_1.5",
                                  @"id":self.editManager.user.userId,
                                  @"page":page};

    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        //获取总页数
        self.pageCount = [[[[root elementsForName:@"allpage"] firstObject] stringValue] intValue];
        
        //数据库操作
        NSArray * message_list = [[[root elementsForName:@"message_list"] firstObject] elementsForName:@"message"];
        
        ///删除数据库内容
        if (message_list.count > 0 && self.pageIndex == 1) {
            [self.sqlManager deleteFromTableName:TABLE_Message where:[NSString stringWithFormat:@"user_id=\"%@\"",self.editManager.user.userId]];
        }else {
            [self.sqlManager deleteFromTableName:TABLE_Message where:[NSString stringWithFormat:@"user_id=\"%@\" and page=\"%@\"",self.editManager.user.userId,page]];
        }
        //插入数据库
        for (int i=0; i<message_list.count; i++) {
            GDataXMLElement * element = [message_list objectAtIndex:i];
            MDMessage * message = [[MDMessage alloc] initWithElement:element];
            message.page = page;
            message.user_id = self.editManager.user.userId;
            [self.sqlManager insertItem:message];
        }

        
        ///获取本地数据
        [self getSqlMyMessageWithNetStatus:YES];
    } falid:^(NSString *errorMsg) {
        [self getSqlMyMessageWithNetStatus:NO];
    }];
}
- (void)getSqlMyMessageWithNetStatus:(BOOL)status {
//    Extracts my news tabulation from sql
    
    NSString * where = [NSString stringWithFormat:@"user_id=\"%@\" and page=\"%d\"",self.editManager.user.userId,self.pageIndex];
    
    NSArray * arr = [self.sqlManager selectTableName:TABLE_Message parameters:@[@"*"] where:where];
   
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (arr.count > 0) {//有数据
        [self.dataArray addObjectsFromArray:arr];
        if (!status) {//如果没有网络时候,提示使用缓存
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_CACHE duration:1.5];
        }
        self.pageIndex++;
    }else {
        if (status) {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_NONE duration:1.5];
        }else {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1.5];
        }
    }
    
    
    
    if (status) {
        [self reloadData];
    }else {
        [self performSelector:@selector(reloadData) withObject:nil afterDelay:1];
        self.pageCount = ([[XYSqlManager defaultService] selectCountWithTableName:TABLE_Message where:[NSString stringWithFormat:@"user_id=\"%@\"",self.editManager.user.userId]]+19)/20;
    }
}





#pragma mark - tableViewDelgate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDMessage * message = [self.dataArray objectAtIndex:indexPath.row];
    NSString * str = message.message;
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(740, 10000)];
    
    return size.height+95;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    if (cell == nil) {
        cell = [[XYMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"message"];
    }
    [cell setMessage:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!IOS7) {//如果版本低于ios7
        XYMessageCell * cell = (XYMessageCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.leftMove = YES;
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!IOS7) {//如果小于ios7
        XYMessageCell * cell = (XYMessageCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.leftMove = NO;
    }
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (!IOS7) {//如果小于ios7
            XYMessageCell * cell = (XYMessageCell*)[tableView cellForRowAtIndexPath:indexPath];
            cell.leftMove = NO;
//            CGRect frame = cell.contentView.frame;
//            frame.origin.x = 0;
//            [UIView animateWithDuration:0.25 animations:^{
//                cell.bgView.frame = frame;
//            } completion:nil];
        }
        MDMessage * message = [self.dataArray objectAtIndex:indexPath.row];
        if (self.netStatus) {
            NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"pad_2.1",@"mode",
                                         message.user_id,@"id",
                                         message.idString,@"msgId",nil];
            [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
                NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
                NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
                
                if ([result isEqualToString:@"yes"]) {
                    [self.dataArray removeObjectAtIndex:indexPath.row];
                    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
                    NSString * where = [NSString stringWithFormat:@"user_id=\"%@\" and idString=\"%@\"",message.user_id,message.idString];
                    [self.sqlManager deleteFromTableName:TABLE_Message where:where];
                }else {
                    [SVProgressHUD showErrorWithStatus:msg duration:1.5f];
                }
            } falid:^(NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:@"删除消息失败" duration:1.5f];
            }];
        }else {
            [SVProgressHUD showErrorWithStatus:@"请检查网络" duration:1.5f];
        }
    }
}


#pragma mark - EGO


- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshHeader) {//刷新
        self.pageIndex = 1;
    }
    if (self.pageIndex > 0 && self.pageIndex <= self.pageCount) {
        [self getMyMessage];
    }
    else {
        self.isLoading = YES;
        [SVProgressHUD showErrorWithStatus:@"没有更多消息了" duration:1.5f];
        [self performSelector:@selector(reloadData) withObject:nil afterDelay:1];
    }
}
@end
