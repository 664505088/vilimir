//
//  XYChildView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYChildView : UIView

- (void)pushView:(UIView*)view;
- (void)pushView:(UIView*)view completion:(void (^)(BOOL finished))completion;

@end
