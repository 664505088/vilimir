//
//  XYEpaperCalendarView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSelectView.h"
#import "XYEpaperCalendarCell.h"
@interface XYEpaperCalendarView : UIView
<UITableViewDelegate>
{
    NSMutableArray * _dateArray;
    NSMutableArray * _titleArray;
    NSDate * _date;
    id _target;
    SEL _action;
}
@property (nonatomic, strong) XYSelectView * yearSelectView;
@property (nonatomic, strong) XYSelectView * monthSelectView;
@property (nonatomic, strong) UIButton * confirmBtn;
@property (nonatomic, strong) UILabel  * titleLabel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic) int year;
@property (nonatomic) int month;

- (void)addTarget:(id)target action:(SEL)action;
@end
