//
//  MDNews.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDNews.h"
#import "GDataXMLNode.h"
@implementation MDNews

- (id)initWithElement:(GDataXMLElement*)element {
    if (self = [super init]) {
        self.idString = [[[element elementsForName:@"id"] firstObject] stringValue];
        self.title = [[[element elementsForName:@"title"] firstObject] stringValue];
        self.title_img = [[[element elementsForName:@"title_img"] firstObject] stringValue];
        self.shot_title = [[[element elementsForName:@"shot_title"] firstObject] stringValue];
        self.content_summary = [[[element elementsForName:@"content_summary"] firstObject] stringValue];
        self.detail_url = [[[element elementsForName:@"detail_url"] firstObject] stringValue];
    }
    return self;
}



//从服务器获取数据
- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.idString = [rs stringForColumn:@"idString"];
        self.title = [rs stringForColumn:@"title"];
        self.title_img = [rs stringForColumn:@"title_img"];
        self.shot_title = [rs stringForColumn:@"shot_title"];
        self.content_summary = [rs stringForColumn:@"content_summary"];
        self.detail_url = [rs stringForColumn:@"detail_url"];
        
        //服务器的
        self.column_id = [rs stringForColumn:@"column_id"];
        self.page = [rs stringForColumn:@"page"];
    }
    return self;
}


- (NSDictionary *)dictionaryValue {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    if (self.idString) {
//        [dic setValue:self.idString forKey:@"idString"];
//    }
//    if (self.title) {
//        [dic setValue:self.title forKey:@"title"];
//    }
//    if (self.shot_title) {
//        [dic setValue:self.shot_title forKey:@"shot_title"];
//    }
//    if (self.detail_url) {
//        [dic setValue:self.detail_url forKey:@"detail_url"];
//    }
//    if (self.title_img) {
//        [dic setValue:self.title_img forKey:@"title_img"];
//    }
//    if (self.content_summary) {
//        [dic setValue:self.content_summary forKey:@"content_summary"];
//    }
//    if (self.content_summary) {
//        [dic setValue:self.content_summary forKey:@"content_summary"];
//    }
//    if (self.head_img) {
//        [dic setValue:self.head_img forKey:@"head_img"];
//    }
    return dic;
}

@end
