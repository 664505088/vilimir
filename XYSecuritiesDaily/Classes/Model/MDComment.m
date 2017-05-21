//
//  MDComment.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDComment.h"
#import "GDataXMLNode.h"
@implementation MDComment

- (void)insertWithFrom_id:(NSString *)from_id
                     type:(NSString *)type
                     is_my:(NSString *)is_my
                     page:(NSString *)page {
    self.from_id = from_id;
    self.page = page;
    if (is_my==nil) {
        self.is_my = MDCOMMENT_TYPE_NOTMY;
    }else {
        self.is_my = is_my;
    }
    
    self.type = type;
}

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        //共有
        self.idString = [[[element elementsForName:@"id"] firstObject] stringValue];
        self.content = [[[element elementsForName:@"content"] firstObject] stringValue];
        self.create_time = [[[element elementsForName:@"create_time"] firstObject] stringValue];
        
        self.user_name = [[[element elementsForName:@"user_name"] firstObject] stringValue];
        self.parent_content = [[[element elementsForName:@"parent_content"] firstObject] stringValue];
        self.parent_user_name = [[[element elementsForName:@"parent_user_name"] firstObject] stringValue];
       
        
        
        //新闻
        self.news_title = [[[element elementsForName:@"news_title"] firstObject] stringValue];
        self.status = [[[element elementsForName:@"status"] firstObject] stringValue];
        //图集
        if (self.news_title==nil) {
            self.news_title = [[[element elementsForName:@"img_title"] firstObject] stringValue];
        }
        if (self.content == nil) {
            self.content = [[[element elementsForName:@"comment"] firstObject] stringValue];
        }
        //我的跟帖
        if (self.news_title == nil) {
            self.news_title = [[[element elementsForName:@"title"] firstObject] stringValue];
            self.column_id = [[[element elementsForName:@"column_id"] firstObject] stringValue];
        }
    }
    return self;
}


//从数据库获取数据
- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.content = [rs stringForColumn:@"content"];
        self.create_time = [rs stringForColumn:@"create_time"];
        self.news_title = [rs stringForColumn:@"news_title"];
        self.user_name = [rs stringForColumn:@"user_name"];
        
        self.parent_content = [rs stringForColumn:@"parent_content"];
        self.parent_user_name = [rs stringForColumn:@"parent_user_name"];
        //数据库区分字段
        self.idString = [rs stringForColumn:@"idString"];
        self.from_id = [rs stringForColumn:@"from_id"];
        self.column_id = [rs stringForColumn:@"column_id"];
        self.page = [rs stringForColumn:@"page"];
        self.type = [rs stringForColumn:@"type"];
        self.is_my = [rs stringForColumn:@"is_my"];
        self.my_user_id = [rs stringForColumn:@"my_user_id"];
        self.status = [rs stringForColumn:@"status"];
    }
    return self;
}
@end
