//
//  MDNew.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"

@interface MDNew : XYObject

@property (nonatomic, copy) NSString *idString;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *shot_title;
@property (nonatomic, copy) NSString *detail_url;


//服务器存储条件
@property (nonatomic, copy) NSString * column_id;

@end
