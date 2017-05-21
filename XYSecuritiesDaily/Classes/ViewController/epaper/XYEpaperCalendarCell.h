//
//  XYEpaperCalendarCell.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYEpaperCalendarDelegate.h"
@interface XYEpaperCalendarCell : UITableViewCell
{
    NSInteger row;
}
@property (nonatomic, strong) NSArray * days;
@property (nonatomic) id <XYEpaperCalendarDelegate>delegate;

- (void)setDays:(NSArray *)days delegate:(id<XYEpaperCalendarDelegate>)delegate indexPath:(NSIndexPath*)indexPath;

@end
