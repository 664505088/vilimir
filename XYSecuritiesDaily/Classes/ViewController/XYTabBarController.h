//
//  XYTabBarController.h
//  XYSecuritiesDaily
//  分栏控制器
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface XYTabBarController : UITabBarController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * viewControllers;
    XYSqlManager * _sqlManager;
}

@property (nonatomic, strong)NSMutableArray * menuArray;
@property (nonatomic, strong)UITableView * menuTableView;

@end
