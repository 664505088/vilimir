//
//  CATransition+Animation.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-30.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "CATransition+Animation.h"


@implementation CATransition (Animation)
+ (CATransition*)transactionWithDuration:(CFTimeInterval)t
                                    type:(NSString*)type {
    CATransition *trans =[CATransition animation];
    [trans setDuration:t];
    [trans setType:type];
    [trans setSubtype:kCATransitionFromLeft];
    return trans;
}




@end
