//
//  MDHeadNews.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-29.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDHeadNews.h"
#import "GDataXMLNode.h"
@implementation MDHeadNews

- (id)initWithElement:(GDataXMLElement*)element {
    if (self = [super init]) {
        self.idString = [[[element elementsForName:@"id"] firstObject] stringValue];
        self.title = [[[element elementsForName:@"title"] firstObject] stringValue];
        self.head_img = [[[element elementsForName:@"head_img"] firstObject] stringValue];
        self.shot_title = [[[element elementsForName:@"shot_title"] firstObject] stringValue];
        self.detail_url = [[[element elementsForName:@"detail_url"] firstObject] stringValue];
    }
    return self;
}



//从服务器获取数据
- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.idString = [rs stringForColumn:@"idString"];
        self.title = [rs stringForColumn:@"title"];
        self.head_img = [rs stringForColumn:@"head_img"];
        self.shot_title = [rs stringForColumn:@"shot_title"];
        self.shot_title = [rs stringForColumn:@"shot_title"];
        self.detail_url = [rs stringForColumn:@"detail_url"];
        
        //服务器的
        self.column_id = [rs stringForColumn:@"column_id"];
    }
    return self;
}


@end
