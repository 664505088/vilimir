//
//  MDNewsDetail.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-9.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"

@interface MDNewsDetail : XYObject

@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * create_time;
@property (nonatomic, copy)NSString * channels;
@property (nonatomic, copy)NSArray  * images;
@property (nonatomic, copy)NSString * content;

@end
