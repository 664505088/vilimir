//
//  XYEpaperNavigationViewController.h
//  XYSecuritiesDaily
//  版面导航
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"
#import "XYEpaperVersionDelegate.h"
@interface XYEpaperNavigationViewController : XYChildViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView         * _tableView;
}

@property (nonatomic, assign) id <XYEpaperVersionDelegate>delegate;

@property (nonatomic, retain) NSArray * dataArray;


@end
