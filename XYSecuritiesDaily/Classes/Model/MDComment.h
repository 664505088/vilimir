//
//  MDComment.h
//  XYSecuritiesDaily
//  跟帖
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"

@interface MDComment : XYObject

#define MDCOMMENT_TYPE_NEWS @"news"
#define MDCOMMENT_TYPE_PHOTOS @"photos"

#define MDCOMMENT_TYPE_MY @"1"
#define MDCOMMENT_TYPE_NOTMY @"0"


@property (nonatomic, copy) NSString *from_id;//
@property (nonatomic, copy) NSString *column_id;//如果是新闻
@property (nonatomic, copy) NSString *status;//跟帖状态 0未审已发布，1未审未发布，2通过审核，3已删除
@property (nonatomic, copy) NSString *type;//news/photos/

@property (nonatomic, copy) NSString *idString;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *parent_user_name;
@property (nonatomic, copy) NSString *parent_content;


@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *news_title;


@property (nonatomic, copy) NSString *is_my;//0or1  或 nil/1
@property (nonatomic, copy) NSString *my_user_id;//如果is_my==1 需要设置该值
@property (nonatomic, copy) NSString *page;


- (void)insertWithFrom_id:(NSString*)from_id
                     type:(NSString*)type
                     is_my:(NSString*)is_my
                     page:(NSString*)page;


@end
