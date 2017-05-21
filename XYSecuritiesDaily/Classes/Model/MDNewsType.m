//
//  MDNewsType.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDNewsType.h"
#import "GDataXMLNode.h"
@implementation MDNewsType

- (id)initWithElement:(GDataXMLElement*)element {
    if (self = [super init]) {
        self.name = [[[element elementsForName:@"name"] firstObject] stringValue];
        self.idString = [[[element elementsForName:@"id"] firstObject] stringValue];
        self.has_head = [[[element elementsForName:@"has_head"] firstObject] stringValue];
    }
    return self;
}

- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.idString = [rs stringForColumn:@"idString"];
        self.name = [rs stringForColumn:@"name"];
        self.has_head = [rs stringForColumn:@"has_head"];
    }
    return self;
}

@end
