//
//  MDObject.h
//  xml转换
//
//  Created by xiwang on 14-10-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
//#import "FMResultSet.h"
@class GDataXMLElement;
@class FMResultSet;
@interface MDObject : NSObject<NSCopying,NSMutableCopying>


+ (NSArray*)allKeys;
- (NSArray*)allKeys;
- (NSDictionary *)dictionaryValue;



//转换成二进制
- (NSData*)dataValue;
- (BOOL)writeToFile:(NSString *)path;//存到目录
+ (id)objectWithData:(NSData*)data;//二进制转换成对象
+ (id)objectWithContentFile:(NSString *)path;//从目录获取对象


- (id)initWithDictionary:(NSDictionary*)dic;
- (id)initWithElement:(GDataXMLElement*)element;
- (id)initWithResultSet:(FMResultSet*)rs;@end
