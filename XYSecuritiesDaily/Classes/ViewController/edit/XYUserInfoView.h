//
//  XYUserInfoView.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"
#define SUB_VIEW_TAG 10
@interface XYUserInfoView : XYChildView

@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) NSMutableArray*toolButtons;

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *phoneLabel;
@property (nonatomic, strong) UILabel       *mailLabel;


@end
