//
//  XYChildView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"

@implementation XYChildView

- (void)pushView:(UIView *)view {
    [UIView transitionFromView:self
                        toView:view
                      duration: 0.5
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:nil];
}

- (void)pushView:(UIView*)view completion:(void (^)(BOOL finished))completion {
    [UIView transitionFromView:self
                        toView:view
                      duration: 0.5
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (completion) {
                            completion(finished);
                        }   
                    }];
}

@end
