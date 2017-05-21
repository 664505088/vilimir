//
//  XYRefreshTableFootView.h
//  XYSecuritiesDaily
//  左右滑动->右侧视图
//  Created by xiwang on 14-7-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kREFRESH_PHOTO_DETAIL_FOOT_LAST_DATE @"footPhotoDetailLastDate"

@interface XYRefreshTableFootView : UIView

@property (nonatomic, strong) UILabel       * titleLabel;
@property (nonatomic, strong) UILabel       * subTitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView    * activity;

- (void)stopWithTitle:(NSString*)title;
- (void)startWithScrollView:(UIScrollView*)scrollView;
@end
