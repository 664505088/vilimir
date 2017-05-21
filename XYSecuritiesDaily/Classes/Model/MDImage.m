//
//  MDImage.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDImage.h"
#import "GDataXMLNode.h"
@implementation MDImage


- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.idString = [[[element elementsForName:@"id"] firstObject] stringValue];
        self.listName = [[[element elementsForName:@"listName"] firstObject] stringValue];
        self.descript = [[[element elementsForName:@"descript"] firstObject] stringValue];
        self.img_url = [[[element elementsForName:@"img_url"] firstObject] stringValue];
        self.width = [[[element elementsForName:@"width"] firstObject] stringValue];
        self.height = [[[element elementsForName:@"height"] firstObject] stringValue];
    }
    return self;
}


- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.idString = [rs stringForColumn:@"idString"];
        self.listName = [rs stringForColumn:@"listName"];
        self.descript = [rs stringForColumn:@"descript"];
        self.img_url = [rs stringForColumn:@"img_url"];
        self.width = [rs stringForColumn:@"width"];
        self.height = [rs stringForColumn:@"height"];
    }
    return self;

}

@end
