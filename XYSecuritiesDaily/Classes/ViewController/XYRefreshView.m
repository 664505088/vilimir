//
//  XYRefreshView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRefreshView.h"

@implementation XYRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [XYFactory createImageViewWithFrame:CGRectMake((self.bounds.size.width-42)/2, 220.5, 42, 42) Image:@"refresh_fail"];
        [self addSubview:_imageView];
        
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectMake((self.bounds.size.width-270)/2, 270, 270, 25) Text:@"数据获取失败," Color:[UIColor grayColor] Font:20 textAlignment:1];
        [self addSubview:_titleLabel];
        
        self.subTitleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 300, frame.size.width, 25) Text:@"请检查网络后点击“刷新”按钮" Color:[UIColor grayColor] Font:20 textAlignment:1];
        [self addSubview:_subTitleLabel];
    }
    return self;
}

- (void)showRefreshViewIsOK:(BOOL)isOK title:(NSString *)title subTitle:(NSString *)subTitle {
    self.hidden = NO;
    if (isOK == NO) {
        _imageView.image = [UIImage imageNamed:@"refresh_fail"];
    }else {
        
    }
    if (title) {
        self.titleLabel.text = title;
    }
    if (subTitle) {
        self.subTitleLabel.text = subTitle;
    }
    
}

- (void)close {
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.alpha = 1;
                         self.hidden = YES;
                     }];
    
}

@end
