//
//  CATransition+Animation.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-30.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define CATransitionTypePageCurl            @"pageCurl"     //向上翻一页
#define CATransitionTypeRippleEffect        @"rippleEffect"//水滴
#define CATransitionTypePageUnCurl          @"pageUnCurl"//向下翻一页
#define CATransitionTypeSuckEffect          @"suckEffect"//收缩效果，布被抽走
#define CATransitionTypeCube                @"cube"//立方体效果
#define CATransitionTypeOglFlip             @"oglFlip"//上下翻转效果
#define CATransitionTypeFlip                @"flip"//左右翻转

@interface CATransition (Animation)

+ (CATransition*)transactionWithDuration:(CFTimeInterval)t
                                    type:(NSString*)type;
@end
