//
//  MDCollect.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"
#import "MDNews.h"
#import "MDHeadNews.h"
#import "MDImage.h"
@interface MDCollect : XYObject

@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * column_id;
@property (nonatomic, copy) NSString * idString;
@property (nonatomic, copy) NSString * page;


@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * descript;
@property (nonatomic, copy) NSString * img_url;
@property (nonatomic, copy) NSString * comment_count;

@property (nonatomic, copy) NSString * create_date;

- (id)initWithItem:(id)item;
- (id)exportObjectWithType:(NSString*)type;
@end
