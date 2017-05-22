//
//  UIWebView+FontSize.h
//  XYMon
//
//  Created by farben on 14-1-7.
//  Copyright (c) 2014年 Shoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (FontSize)
///value = value% 10%~xxxx%
- (void)fontSizeToFit:(float)value;
@end
