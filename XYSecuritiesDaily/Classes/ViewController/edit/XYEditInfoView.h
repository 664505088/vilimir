//
//  XYEditInfoView.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"
#define SUB_VIEW_TAG 10
@interface XYEditInfoView : XYChildView
<UITextFieldDelegate>

@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) NSMutableArray*toolButtons;

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) NSMutableArray*textFields;


@end
