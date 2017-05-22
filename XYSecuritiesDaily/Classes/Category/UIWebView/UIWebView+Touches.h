//
//  UIWebView+Touches.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Touches)
- (void)addTouchesJavaScript;
- (BOOL)isTouchesEndWithRequest:(NSURLRequest*)request;
@end
