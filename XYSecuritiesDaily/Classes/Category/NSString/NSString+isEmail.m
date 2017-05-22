//
//  NSString+isEmail.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-20.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "NSString+isEmail.h"

@implementation NSString (isEmail)

///验证邮箱合法性-(正则表达式)
-(BOOL)isEmail{
    if ([self rangeOfString:@"@"].location != NSNotFound
        && ([self rangeOfString:@".com"].location != NSNotFound
            || [self rangeOfString:@".cn"].location != NSNotFound
            || [self rangeOfString:@".net"].location != NSNotFound)) {
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:self];
        }
    else {
        return NO;
    }
}

@end
