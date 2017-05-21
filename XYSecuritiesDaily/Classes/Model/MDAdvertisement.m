//
//  MDAdvertisement.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-26.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDAdvertisement.h"
#import "GDataXMLNode.h"
@implementation MDAdvertisement

- (id)initWithElement:(id)element {
    if (self = [super init]) {
        self.ad_img = [[[element elementsForName:@"ad_img"] firstObject] stringValue];
        self.ad_img_url = [[[element elementsForName:@"ad_img_url"] firstObject] stringValue];
    }
    return self;
}

- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.ad_img = [rs stringForColumn:@"ad_img"];
        self.ad_img_url = [rs stringForColumn:@"ad_img_url"];
    }
    return self;
}


@end
