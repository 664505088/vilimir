//
//  UIWebView+Touches.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "UIWebView+Touches.h"
static NSString* const kTouchJavaScriptString=
@"document.ontouchstart=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"thweb:touch:start:\"+x+\":\"+y;};\
document.ontouchmove=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"thweb:touch:move:\"+x+\":\"+y;};\
document.ontouchcancel=function(event){\
document.location=\"thweb:touch:cancel\";};\
document.ontouchend=function(event){\
document.location=\"thweb:touch:end\";};";

@implementation UIWebView (Touches)
- (void)addTouchesJavaScript {
    [self stringByEvaluatingJavaScriptFromString:kTouchJavaScriptString];
}


///是否被点击
- (BOOL)isTouchesEndWithRequest:(NSURLRequest*)request {
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 2
		&& [(NSString *)[components objectAtIndex:0] isEqualToString:@"thweb"]
		&& [(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
	{
        NSString *eventString=[components objectAtIndex:2];
		if ([eventString isEqualToString:@"start"]) {
            return YES;
			//开始点击
		}else if ([eventString isEqualToString:@"end"]) {
            //点击结束
            return YES;
		}
        return NO;
    }
    return NO;
}

#pragma mark - 使用
//- (BOOL)webView:(UIWebView*)aWebView
//shouldStartLoadWithRequest:(NSURLRequest*)aRequest
// navigationType:(UIWebViewNavigationType)aNavigationType {
//	
//    NSString *requestString = [[aRequest URL] absoluteString];
//    NSArray *components = [requestString componentsSeparatedByString:@":"];
//    if ([components count] > 2
//		&& [(NSString *)[components objectAtIndex:0] isEqualToString:@"thweb"]
//		&& [(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
//	{
//        NSString *eventString=[components objectAtIndex:2];
//		if ([eventString isEqualToString:@"start"]) {
//			//开始点击
//		}else if ([eventString isEqualToString:@"end"]) {
//            //点击结束
//		}
//        return NO;
//    }
//	
//    return YES;
//}

@end
