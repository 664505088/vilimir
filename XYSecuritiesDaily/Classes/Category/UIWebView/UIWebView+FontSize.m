//
//  UIWebView+FontSize.m
//  XYMon
//
//  Created by farben on 14-1-7.
//  Copyright (c) 2014年 Shoo. All rights reserved.
//

#import "UIWebView+FontSize.h"

@implementation UIWebView (FontSize)



- (void)fontSizeToFit:(float)value {
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",value];
    [self stringByEvaluatingJavaScriptFromString:str1];
}

@end
