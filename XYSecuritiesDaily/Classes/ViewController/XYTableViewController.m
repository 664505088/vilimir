//
//  XYTableViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-6.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"

@interface XYTableViewController ()

@end

@implementation XYTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    
    if (self.pageCount == 0) {
        self.pageCount = 1;
    }
    if (self.pageIndex == 0) {
        self.pageIndex = 1;
    }
    
    
    self.view.frame = CGRectMake(0, 0, H_WIDTH, H_HEIGHT);
    
    //表格(横版)
    self.tableView = [XYFactory createTableViewWithFrame:self.xView.bounds horizontal:YES style:UITableViewStylePlain delegate:self];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.xView addSubview:_tableView];
    
    //创建刷新失败视图
    self.xRefreshFailView = [[XYRefreshView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_xRefreshFailView];
    _xRefreshFailView.hidden = YES;

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}





@end
