//
//  XYEpaperVersionDelegate.h
//  XYSecuritiesDaily
//  选择版本
//  Created by xiwang on 14-8-5.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYEpaperVersionDelegate <NSObject>

- (void)epaperDateWithIndex:(NSInteger)index;

@end
