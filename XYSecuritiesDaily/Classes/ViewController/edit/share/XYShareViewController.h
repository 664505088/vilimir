//
//  XYShareViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"



@interface XYShareViewController : XYChildViewController

@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * descriptionString;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic) SSPublishContentMediaType mediaType;
@end
