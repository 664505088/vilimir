//
//  XYTableViewController.h
//  SecuritiesDaily
//  基于XYViewController(附加横版tableview/刷新失败视图)
//  Created by xiwang on 14-6-6.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//


#import "XYViewController.h"

#import "MDPage.h"
#import "XYPageIndexControl.h"
#import "XYRefreshView.h"


@interface XYTableViewController : XYViewController
<UITableViewDataSource,UITableViewDelegate>



///tableView 添加再主视图中
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) NSMutableArray    * dataArray;
//刷新失败显示
@property (nonatomic, strong)XYRefreshView * xRefreshFailView;
@property (nonatomic) int   pageIndex;
@property (nonatomic) int   pageCount;









@end
