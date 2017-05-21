//
//  MDPhotoDetail.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-6.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDPhotoDetail.h"
#import "GDataXMLNode.h"
@implementation MDPhotoDetail

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.imgName = [[[element elementsForName:@"imgName"] firstObject] stringValue];
        self.descript = [[[element elementsForName:@"descript"] firstObject] stringValue];
        self.gallery_name = [[[element elementsForName:@"gallery_name"] firstObject] stringValue];
        self.img_url = [[[element elementsForName:@"img_url"] firstObject] stringValue];
        self.comment_count = [[[element elementsForName:@"comment_count"] firstObject] stringValue];
    }
    return self;
}


- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.imgName = [rs stringForColumn:@"imgName"];
        self.descript = [rs stringForColumn:@"descript"];
        self.gallery_name = [rs stringForColumn:@"gallery_name"];
        self.img_url = [rs stringForColumn:@"img_url"];
        self.comment_count = [rs stringForColumn:@"comment_count"];
        
        self.page = [rs stringForColumn:@"page"];
        self.idString = [rs stringForColumn:@"idString"];
        self.img_width = [rs stringForColumn:@"img_width"];
    }
    return self;
    
}

@end
