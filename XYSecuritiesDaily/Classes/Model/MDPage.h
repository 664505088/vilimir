//
//  MDPage.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDPage : NSObject

@property (nonatomic) int page;
@property (nonatomic) int count;

@property (nonatomic) int head;
@property (nonatomic) int pageCount1;
@property (nonatomic) int pageCount2;
@property (nonatomic,copy) NSString * has_head;

//解析结果
@property (nonatomic,readonly) int pageBigMax;
@property (nonatomic,readonly) int pageSmallMax;

- (id)initWithHead:(int)h page1:(int)page1 page2:(int)page2;

- (int)pageBigMaxWithCount:(int)count;
- (int)pageSmallMaxWithCount:(int)count;
@end
