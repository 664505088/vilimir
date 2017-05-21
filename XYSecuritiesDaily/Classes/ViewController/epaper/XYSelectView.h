//
//  XYSelectView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-5.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSelectView : UIView
<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic) id <UITableViewDelegate> delegate;
@property (nonatomic, retain) NSArray * titleArray;

@property (nonatomic) NSInteger index;

@end
