//
//  XYEditManager.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEditManager.h"

@implementation XYEditManager

static XYEditManager * _editManager;
+ (XYEditManager *)shardManager{
    @synchronized(self) {
        if (!_editManager){
            _editManager = [[XYEditManager alloc] init];
        }
    }
    return _editManager;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (_editManager == nil) {
            return [super allocWithZone:zone];
        }
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
        self.sinaWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo];
        self.tencentWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeTencentWeibo];;
        self.netEaseWeibo = [ShareSDK hasAuthorizedWithType:ShareType163Weibo];
        
        float font = [[NSUserDefaults standardUserDefaults] floatForKey:@"font"];
        self.fontSize = font>0?font:XYEditFontSmallSize;
        
        self.screen = [[NSUserDefaults standardUserDefaults] boolForKey:@"screen"];
        self.page = [[NSUserDefaults standardUserDefaults] boolForKey:@"page"];
        
        self.version = [dic objectForKey:@"CFBundleShortVersionString"];
        
        self.user = [[MDUser alloc] init];
        self.user.isLogin = NO;
        //测试
//        self.user.userId = @"23";
    }
    return self;
}

- (void)setScreen:(BOOL)screen {
    if (_screen != screen) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCREEN object:self userInfo:@{@"old":[NSNumber numberWithFloat:_screen],
                                                                                                            @"new":[NSNumber numberWithFloat:screen]}];
        _screen = screen;
        
        [[NSUserDefaults standardUserDefaults] setBool:_screen forKey:@"screen"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}
- (void)setPage:(BOOL)page {
    if (_page != page) {
        _page = page;
        [[NSUserDefaults standardUserDefaults] setBool:_page forKey:@"page"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setFontSize:(float)fontSize {
    if (_fontSize != fontSize) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FONT object:self userInfo:@{@"old":[NSNumber numberWithFloat:_fontSize],
                                                                                                            @"new":[NSNumber numberWithFloat:fontSize]}];
        _fontSize = fontSize;
        [[NSUserDefaults standardUserDefaults] setFloat:_fontSize forKey:@"font"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
}

@end
