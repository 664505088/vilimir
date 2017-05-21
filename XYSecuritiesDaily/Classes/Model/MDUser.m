//
//  MDUser.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDUser.h"

@implementation MDUser

- (void)setUsername:(NSString *)username {
    if (_username != username) {
        _username = nil;
        _username = [username copy];
    }
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_username forKey:@"username"];
    [userDefaults synchronize];
}

- (void)setPassword:(NSString *)password {
    if (_password != password) {
        _password = nil;
        _password = [password copy];
    }
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_password forKey:@"password"];
    [userDefaults synchronize];
}

- (void)setToken:(NSString *)token {
    if (_token != token) {
        _token = nil;
        _token = [token copy];
    }
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_token forKey:@"token"];
    [userDefaults synchronize];
}

- (void)setUserId:(NSString *)userId {
    if (_userId != userId) {
        _userId = [userId copy];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_userId forKey:@"id"];
        [userDefaults synchronize];
    }
}


@end
