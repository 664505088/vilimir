//
//  XYNewsPageSelectedDelegate.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYNewsPageSelectedDelegate <NSObject>

- (void)selectedNewsItemAtpage:(int)page withIndex:(int)index;

@end
