//
//  XYDevice.h
//  aaaaa
//
//  Created by xiwang on 14-6-11.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/sysctl.h>

///是否iPad
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

///是否iPhone
#define IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

///版本
#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

///是否 ios7
#define IOS7 (VERSION<7.0?NO:YES)



///状态栏高度
#define STATUS_HEIGHT (IOS7?20:0)

///系统屏幕大小
#define WIN_SIZE ([UIScreen mainScreen].bounds.size)


///当前横屏时高宽
#define H_HEIGHT (WIN_SIZE.width-(IOS7?0:20))
#define H_WIDTH (WIN_SIZE.height)

///当前竖屏时高宽
#define V_HEIGHT (WIN_SIZE.height-(IOS7?0:20))
#define V_WIDTH (WIN_SIZE.width)



#define MENU_WIDTH (190/2)
#define NAVIGATION_HEIGHT (65+STATUS_HEIGHT)
#define TOOLBAR_HEIGHT 50

@interface XYDevice : NSObject

///获取设备信息
+ (NSString*)getDeviceVersion;

///获取设备详细信息
+ (NSString *) platformString;
@end
