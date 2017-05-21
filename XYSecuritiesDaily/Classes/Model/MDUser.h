//
//  MDUser.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDUser : NSObject
@property (nonatomic, copy) NSString    * username;
@property (nonatomic, copy) NSString    * password;

@property (nonatomic, copy) NSString    * image;
@property (nonatomic, copy) NSString    * tel;
@property (nonatomic, copy) NSString    * mail;
@property (nonatomic, copy) NSString    * userId;
@property (nonatomic, copy) NSString    * nickName;

@property (nonatomic, copy) NSString    * token;


@property (nonatomic) BOOL isLogin;

@end
