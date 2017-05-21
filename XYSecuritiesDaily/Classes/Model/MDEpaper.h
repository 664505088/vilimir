//
//  MDEpaper.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"

@interface MDEpaper : XYObject

@property (nonatomic,copy)NSString * title;//版面
@property (nonatomic,copy)NSString * year;//版面
@property (nonatomic,copy)NSString * month;//版面
@property (nonatomic,copy)NSString * day;//版面

@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * pdf;

@end
