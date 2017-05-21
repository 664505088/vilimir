//
//  AppDelegate.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "AppDelegate.h"

#import "XYTabBarController.h"
#import "XYWelcomeViewController.h"

#define kTOKEN @"token"

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[XYWelcomeViewController alloc] init]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTOKEN] == nil) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSMutableString * token = [NSMutableString stringWithFormat:@"%@",deviceToken];
//    [token replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
    NSString *strToken =  [NSString stringWithFormat:@"%@", deviceToken];
    strToken =[strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    strToken =[strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strToken =[strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    [self sendServerToken:strToken];
}
//向服务器发送token
- (void)sendServerToken:(NSString*)token {
    NSDictionary * parameters = @{@"mode":@"2.4",
                                  @"token":token};
    //发送给服务器
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if (![result isEqualToString:@"yes"]) {
//            NSLog(@"发送token失败,重新发送");
//            [self sendServerToken:token];
        }else {
            NSLog(@"发送token成功: %@",token);
            NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
            [myDefaults setObject:token forKey:kTOKEN];
            [myDefaults synchronize];
        }
    } falid:^(NSString *errorMsg) {
        NSLog(@"发送token失败,重新发送");
//        [self sendServerToken:token];
    }];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@",userInfo);
}




- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@",error);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTOKEN] == nil) {
        if (![[XYDevice platformString] isEqualToString:@"Simulator"]) {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        }
    }
}




@end
