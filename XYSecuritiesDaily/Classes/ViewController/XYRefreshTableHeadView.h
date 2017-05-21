//
//  XYRefreshTableHeadView.h
//  XYSecuritiesDaily
//  左右滑动->左侧视图
//  Created by xiwang on 14-7-17.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kREFRESH_PHOTO_DETAIL_HEAD_LAST_DATE @"headPhotoDetailLastDate"
@interface XYRefreshTableHeadView : UIView
@property (nonatomic, strong) UILabel       * titleLabel;
@property (nonatomic, strong) UILabel       * subTitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView    * activity;

- (void)stopWithTitle:(NSString*)title;
- (void)startWithScrollView:(UIScrollView*)scrollView;
@end
