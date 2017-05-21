//
//  MDCollect.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDCollect.h"

@implementation MDCollect


- (id)initWithItem:(id)item {
    if (self = [super init]) {
        if ([item isKindOfClass:[MDNews class]]) {
            MDNews * tmp = item;
            self.type = @"News";
            self.column_id = tmp.column_id;
            self.idString = tmp.idString;
            
            self.page = tmp.page;
            
            if (tmp.shot_title != nil && ![tmp.shot_title isEqualToString:@""]) {
                self.title = tmp.shot_title;
            }else {
                self.title = tmp.title;
            }
            
            self.descript = tmp.detail_url;
            
            self.img_url = tmp.title_img;
            self.comment_count = nil;
        }
        
        else if ([item isKindOfClass:[MDHeadNews class]]) {
            MDHeadNews * tmp = item;
            self.type = @"News";
            self.page = @"0";
            self.column_id = tmp.column_id;
            self.idString = tmp.idString;
            self.title = tmp.title;
            self.descript = tmp.detail_url;
            self.img_url = tmp.head_img;
            self.comment_count = nil;
        }
        
        else if ([item isKindOfClass:[MDImage class]]) {
            MDImage * tmp = item;
            self.type = @"Photos";
            self.column_id = tmp.width;
            self.idString = tmp.idString;
            
            self.page = tmp.page;
            
            self.title = tmp.listName;
            self.descript = tmp.descript;
            
            self.img_url = tmp.img_url;
            
            self.comment_count = tmp.height;
            
        }
    }
    return self;
}

- (id)exportObjectWithType:(NSString*)type {
    if ([type isEqualToString:@"News"]) {
        MDNews * news = [[MDNews alloc] init];
        news.column_id = self.column_id;
        news.idString = self.idString;
        news.page = self.page;
        news.shot_title = self.title;
        news.title_img = self.img_url;
        news.detail_url = self.descript;
        return news;
    }else if ([type isEqualToString:@"Photos"]) {
        MDImage * image = [[MDImage alloc] init];
        image.page = self.page;
        image.idString = self.idString;
        image.listName = self.title;
        image.descript = self.descript;
        image.img_url = self.img_url;
        image.width = self.column_id;
        image.height = self.comment_count;
        return image;
    }
    return nil;
}




- (id)initWithResultSet:(FMResultSet *)rs {
    if (self = [super init]) {
        self.column_id = [rs stringForColumn:@"column_id"];
        self.page = [rs stringForColumn:@"page"];
        self.idString = [rs stringForColumn:@"idString"];
        self.type = [rs stringForColumn:@"type"];
        self.title = [rs stringForColumn:@"title"];
        self.descript = [rs stringForColumn:@"descript"];
        self.img_url = [rs stringForColumn:@"img_url"];
        self.comment_count = [rs stringForColumn:@"comment_count"];
        self.create_date = [rs stringForColumn:@"create_date"];
    }
    return self;
}

@end
