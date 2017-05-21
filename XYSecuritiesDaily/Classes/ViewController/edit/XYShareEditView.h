//
//  XYShareEditView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"

@interface XYShareEditView : XYChildView
<UITextViewDelegate>
@property (nonatomic, strong) UILabel       * titleLabel;
@property (nonatomic, strong) UITextView    * textView;
@property (nonatomic, strong) UILabel       * sizeLabel;
@property (nonatomic, strong) UIButton      * rightButton;

@end
