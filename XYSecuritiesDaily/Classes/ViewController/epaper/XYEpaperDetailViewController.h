//
//  XYEpaperDetailViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYViewController.h"
#import "UIWebView+Touches.h"
#import "MDEpaper.h"
@interface XYEpaperDetailViewController : UIViewController
<UIWebViewDelegate>
{
    UIWebView * _webView;

}

@property (nonatomic, retain)NSMutableArray * arr;
@property (nonatomic, retain) MDEpaper * epaper;

@end
