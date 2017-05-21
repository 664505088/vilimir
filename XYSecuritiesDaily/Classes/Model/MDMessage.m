//
//  MDMessage.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDMessage.h"
#import "GDataXMLNode.h"
@implementation MDMessage

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.message = [[[element elementsForName:@"message"] firstObject] stringValue];
        self.create_time = [[[element elementsForName:@"create_time"] firstObject] stringValue];
        self.idString = [[[element elementsForName:@"msgId"] firstObject] stringValue];
    }
    return self;
}


//从数据库获取数据
- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.message = [rs stringForColumn:@"message"];
        self.create_time = [rs stringForColumn:@"create_time"];
        self.page = [rs stringForColumn:@"page"];
        self.idString = [rs stringForColumn:@"idString"];
        self.user_id = [rs stringForColumn:@"user_id"];
    }
    return self;
}

@end
