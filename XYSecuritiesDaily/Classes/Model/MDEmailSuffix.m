

//
//  MDEmailSuffix.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-1.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDEmailSuffix.h"
#import "GDataXMLNode.h"
@implementation MDEmailSuffix



//从数据库获取数据
- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.name = [rs stringForColumn:@"name"];
        self.suffix = [rs stringForColumn:@"suffix"];
    }
    return self;
}

- (id)initWithName:(NSString*)name suffix:(NSString*)suffix {
    if (self = [super init]) {
        self.name = name;
        self.suffix = suffix;
    }
    return self;
}

@end
