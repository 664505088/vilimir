//
//  XYRefreshView.h
//  SecuritiesDaily
//  刷新失败视图
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYRefreshView : UIView

@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * subTitleLabel;

- (void)showRefreshViewIsOK:(BOOL)isOK
                      title:(NSString*)title
                   subTitle:(NSString*)subTitle;

- (void)close;

@end
