//
//  XYSmallEpaperViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-2.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYSmallEpaperCell.h"
#import "XYSmallEpaperDetailViewController.h"
@interface XYSmallEpaperViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}

- (void)reloadData;

@end
