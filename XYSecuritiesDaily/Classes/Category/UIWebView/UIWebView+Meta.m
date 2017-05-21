//
//  UIWebView+Meta.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-31.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "UIWebView+Meta.h"

@implementation UIWebView (Meta)
- (void)Meta {
    NSString* str1 =[NSString stringWithFormat:@"<meta content=\"width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3\" name=\"viewport\">"];
    [self stringByEvaluatingJavaScriptFromString:str1];
}


@end
