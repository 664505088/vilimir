//
//  XYEditManager.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFICATION_FONT @"kFontSizeChanged"
#define NOTIFICATION_SCREEN @"kScreenChanged"
#import "MDUser.h"



//17*7=119
@interface XYEditManager : NSObject

typedef enum {
    XYEditFontBigSize = 20,
    XYEditFontMiddleSize = 17,
    XYEditFontSmallSize = 14,
}XYEditFontSize;//枚举名称

@property (nonatomic) BOOL sinaWeibo;
@property (nonatomic) BOOL tencentWeibo;
@property (nonatomic) BOOL netEaseWeibo;

@property (nonatomic) float fontSize;//文字
@property (nonatomic) BOOL screen;//全屏
@property (nonatomic) BOOL page;//分页
@property (nonatomic, copy) NSString * version;

@property (nonatomic, strong)MDUser * user;



//获取单利
+ (XYEditManager *)shardManager;
@end
