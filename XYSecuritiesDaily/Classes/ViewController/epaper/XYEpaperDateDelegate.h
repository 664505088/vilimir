//
//  XYEpaperDateDelegate.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-5.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYEpaperDateDelegate <NSObject>

- (void)epaperDateWithYear:(NSString*)year
                     month:(NSString*)month
                       day:(NSString*)day;

@end
