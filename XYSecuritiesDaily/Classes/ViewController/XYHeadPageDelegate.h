//
//  XYHeadPageDelegate.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYHeadPageView;
@protocol XYHeadPageDelegate <NSObject>

- (void)headPageView:(XYHeadPageView *)headPageView didSelectRowAtIndex:(int)index;
@end
