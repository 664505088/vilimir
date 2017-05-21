//
//  XYSmallEpaperViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-2.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYSmallEpaperViewController.h"

@interface XYSmallEpaperViewController ()

@end

@implementation XYSmallEpaperViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor greenColor];
    CGRect frame = CGRectMake(0, 0, 1024-540-10, 768-NAVIGATION_HEIGHT-50);

    _dataArray = [[NSMutableArray alloc] init];
    
    _tableView = [XYFactory createTableViewWithFrame:frame style:UITableViewStylePlain delegate:self];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}

- (void)reloadData {
    [_dataArray removeAllObjects];
    for (int i=0; i<10; i++) {
        NSString * str = @"2014-07-02 16:19:50.650 XYSecuritiesDaily[6273:60b] select * from HeadNews where column_id=2014-07-02 16:19:50.723 XYSecuritiesDaily[6273:60b] column_id=  count=332014-07-02 16:19:50.729 XYSecuritiesDaily[6273:60b] 请求地址:<?xml version='1.0' encoding='utf-8'?><dns version=''><head_img_width>1065</head_img_width><page>2</page><column_id>8</column_id><big_img_width>462</big_img_width><img_width>408</img_width><company_id>2</company_id><ad_img_width>1680</ad_img_width><mode>pad_1.1</mode></dns>2014-07-02 16:19:51.062 XYSecuritiesDaily[6273:60b] select * from News where column_id=2014-07-02 16:19:51.068 XYSecuritiesDaily[6273:60b] column_id=";
        [_dataArray addObject:[str substringToIndex:arc4random()%str.length]];
    }
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * str = [_dataArray objectAtIndex:indexPath.row];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(_tableView.bounds.size.width-80, 10000)];
    return size.height+40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSmallEpaperCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYSmallEpaperCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.titleLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSmallEpaperDetailViewController * vc = [[XYSmallEpaperDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
