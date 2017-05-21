//
//  MDEpaper.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDEpaper.h"
#import "GDataXMLNode.h"
@implementation MDEpaper

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super initWithElement:element]) {
        self.title = [[[element elementsForName:@"title"] firstObject] stringValue];
        self.pdf = [[[element elementsForName:@"pdf"] firstObject] stringValue];
        self.img = [[[element elementsForName:@"img"] firstObject] stringValue];

    }
    return self;
}

- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super initWithResultSet:rs]) {
        self.year = [rs stringForColumn:@"year"];
        self.month = [rs stringForColumn:@"month"];
        self.day = [rs stringForColumn:@"day"];
        
        self.title = [rs stringForColumn:@"title"];
        self.img = [rs stringForColumn:@"img"];
        self.pdf = [rs stringForColumn:@"pdf"];
    }
    return self;
}


- (NSString *)description {
    NSMutableString * str = [NSMutableString stringWithFormat:@"%@-%@-%@\ntitle:\t%@\nimg:\t%@\npdf:\t%@",self.year,
                             self.month,
                             self.day,
                             self.title,
                             self.img,
                             self.pdf];
    return str;
}

@end
