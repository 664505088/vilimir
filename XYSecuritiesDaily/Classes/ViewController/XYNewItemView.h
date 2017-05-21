//
//  XYNewItemView.h
//  SecuritiesDaily
//  某条新闻显示
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDNews.h"
#import "UILabel+FitView.h"
@interface XYNewItemView : UIView

@property (nonatomic, retain)UIView     * normal_bg1;
@property (nonatomic, retain)UIImageView* normal_bg2;
@property (nonatomic, retain)UILabel    * titleLabel;
@property (nonatomic, retain)UIImageView* imageView;
@property (nonatomic, retain)UILabel    * subTitleLabel;

- (void)setNews:(MDNews*)news;

@end
