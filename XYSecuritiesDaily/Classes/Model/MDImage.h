//
//  MDImage.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"
//#import "GDataXMLNode.h"
@interface MDImage : XYObject


@property (nonatomic, copy)NSString * idString;
@property (nonatomic, copy)NSString * listName;
@property (nonatomic, copy)NSString * descript;
@property (nonatomic, copy)NSString * img_url;
@property (nonatomic, copy)NSString * width;
@property (nonatomic, copy)NSString * height;


@property (nonatomic, copy)NSString * page;


- (id)initWithElement:(GDataXMLElement*)element;
@end
