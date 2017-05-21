//
//  MDObject.m
//  xml转换
//
//  Created by xiwang on 14-10-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDObject.h"
#import "GDataXMLNode.h"
@implementation MDObject
- (id)copyWithZone:(NSZone *)zone {
    id obj = [[[self class] allocWithZone:zone] init];
    for (NSString * key in self.allKeys) {
        if ([self valueForKey:key]) {
            [obj setValue:[self valueForKey:key] forKey:key];
        }
    }
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    id obj = [[[self class] allocWithZone:zone] init];
    for (NSString * key in self.allKeys) {
        if ([self valueForKey:key]) {
            id par = [[self valueForKey:key] copy];
            [obj setValue:par forKey:key];
        }
    }
    return obj;
}
///从服务器解析数据
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        for (NSString * key in self.allKeys) {
            id obj = [dic objectForKey:key];
            if (obj != nil) {
                [self setValue:obj forKey:key];
            }
        }
    }
    return self;
}


///从服务器解析数据
- (id)initWithElement:(GDataXMLElement*)element {
    if (self = [super init]) {
        for (NSString * key in self.allKeys) {
            id obj = [[[element elementsForName:key] firstObject] stringValue];
            if (obj != nil) {
                [self setValue:obj forKey:key];
            }
        }
    }
    return self;
}

//从数据库解析数据
- (id)initWithResultSet:(FMResultSet *)rs {
    self = [super init];
    return self;
}










- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int outCount;
    objc_property_t * propertys = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        NSString * key = [NSString stringWithUTF8String:property_getName(propertys[i])];
        
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        unsigned int outCount;
        objc_property_t * propertys = class_copyPropertyList([self class], &outCount);
        for (int i=0; i<outCount; i++) {
            NSString * key = [NSString stringWithUTF8String:property_getName(propertys[i])];
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return  self;
}


- (NSData*)dataValue {
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
- (BOOL)writeToFile:(NSString *)path {
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)objectWithData:(NSData*)data {
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (id)objectWithContentFile:(NSString *)path {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


+ (NSArray *)allKeys {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray * arr = [NSMutableArray array];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString * name = [NSString stringWithUTF8String:property_getName(property)];
        [arr addObject:name];
    }
    return arr;
}
- (NSArray *)allKeys {
    return [[self class] allKeys];
}

- (NSDictionary *)dictionaryValue {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString * name = [NSString stringWithUTF8String:property_getName(property)];
        NSObject * obj = [self valueForKey:name];
        
        if ([obj isKindOfClass:[MDObject class]]) {
            [dic setObject:((MDObject*)obj).dictionaryValue forKey:name];
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            [dic setObject:[self arrWithArr:(NSArray*)obj] forKey:name];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            [dic setObject:[self dicWithDic:(NSDictionary*)obj] forKey:name];
        }
        else {
            if (obj) [dic setObject:obj forKey:name];
            else {
                //                NSString * type = [NSString stringWithUTF8String:property_getAttributes(property)];
                //                type = [type substringFromIndex:3];
                //                NSRange r = [type rangeOfString:@"\""];
                //                type = [type substringToIndex:r.location];
                //                if ([type isEqualToString:@"NSString"]) {
                //                    [dic setObject:@"" forKey:name];
                //                }else {
                //                    NSLog(@"%@",type);
                //                }
            }
        }
    }
    return dic;
}

- (NSArray*)arrWithArr:(NSArray*)arr{
    NSMutableArray * tmp = [NSMutableArray array];
    for (NSObject * obj in arr) {
        if ([obj isKindOfClass:[MDObject class]]) {
            [tmp addObject:((MDObject*)obj).dictionaryValue];
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            [tmp addObject:[self arrWithArr:(NSArray*)obj]];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]){
            [tmp addObject:[self dicWithDic:(NSDictionary*)obj]];
        }
        else {
            if (obj) [tmp addObject:obj];
        }
    }
    return tmp;
}
- (NSDictionary*)dicWithDic:(NSDictionary*)dic{
    NSMutableDictionary * tmp = [NSMutableDictionary dictionary];
    for (NSString * key in [dic allKeys]) {
        id obj = [dic objectForKey:key];
        if ([obj isKindOfClass:[MDObject class]]) {
            [tmp setObject:((MDObject*)obj).dictionaryValue forKey:key];
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            [tmp setObject:[self arrWithArr:(NSArray*)obj] forKey:key];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]){
            [tmp setObject:[self dicWithDic:(NSDictionary*)obj] forKey:key];
        }
        else {
            if (obj) [tmp setObject:obj forKey:key];
        }
    }
    return tmp;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@",[super description],[self dictionaryValue].description];
}
@end
