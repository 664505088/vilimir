//
//  MDEpaperCalendar.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDEpaperCalendar.h"
#import "GDataXMLNode.h"
@implementation MDEpaperCalendar
- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super initWithElement:element]) {
        self.date = [element stringValue];

        NSArray * arr = [_date componentsSeparatedByString:@"-"];
        if (arr.count>2) {
            self.year = [arr objectAtIndex:0];
            self.month = [arr objectAtIndex:1];
            self.day = [arr objectAtIndex:2];
        }
        
    }
    return self;
}


- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super initWithResultSet:rs]) {
        self.date = [rs stringForColumn:@"date"];
        
        self.year = [rs stringForColumn:@"year"];
        self.month = [rs stringForColumn:@"month"];
        self.day = [rs stringForColumn:@"day"];
    }
    return self;
}
@end
