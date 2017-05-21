//
//  XYEpaperCalendarViewController.h
//  XYSecuritiesDaily
//  查看往期
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"
#import "XYEpaperCalendarView.h"
#import "XYEpaperDateDelegate.h"
@interface XYEpaperCalendarViewController : XYChildViewController
<UITableViewDataSource,UITableViewDelegate,XYEpaperCalendarDelegate>
{
    XYEpaperCalendarView * _calendarView;
    NSMutableArray * _dateArray;
}

@property (nonatomic, assign) id <XYEpaperDateDelegate>delegate;
@property (nonatomic) BOOL netStatus;
@end
