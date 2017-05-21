//
//  XYEpaperCalendarDelegate.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-5.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYEpaperCalendarDelegate <NSObject>
- (void)epaperSelectedIndexPath:(NSIndexPath*)indexPath;
@end
