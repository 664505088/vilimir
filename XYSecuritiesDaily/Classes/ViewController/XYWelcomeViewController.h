//
//  XYWelcomeViewController.h
//  XYSecuritiesDaily
//  欢迎页
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>


#import "WeiboApi.h"
#import "WXApi.h"
#import "CATransition+Animation.h"
#import "NSString+MD5.h"

#define LoadingDuration 3


//加载loading页面->获取版本->自动登录->跳转主页面

@interface XYWelcomeViewController : UIViewController
<UIAlertViewDelegate>
{
    NSString * _updateUrl;
    NSString * _loadingUrl;
    UIImageView * _loadingImageView;
}
@end
