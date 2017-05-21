//
//  XYHeadPageView.h
//  SecuritiesDaily
//  新闻焦点视图列表
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDHeadNews.h"
#import "XYHeadPageItemCell.h"
#import "XYPageControl.h"

#import "XYHeadPageDelegate.h"
@interface XYHeadPageView : UIView
<UITableViewDataSource,UITableViewDelegate>
{
    NSTimer * _timer;
}
@property (nonatomic, retain) NSArray *dataSouth;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UILabel * titleLabel;
@property (nonatomic, retain) XYPageControl * pageControl;

@property (nonatomic, assign) id <XYHeadPageDelegate>delegate;

@end
