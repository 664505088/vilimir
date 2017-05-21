//
//  MDPage.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "MDPage.h"

@implementation MDPage

- (id)initWithHead:(int)h page1:(int)page1 page2:(int)page2 {
    if (self = [super init]) {
        self.head = h;
        self.pageCount1 = page1;
        self.pageCount2 = page2;
    }
    return self;
}

- (int)pageSmallMaxWithCount:(int)count {
    //计算
    int bigCount = self.pageCount1+self.pageCount2;//15
    
    if ([self.has_head isEqualToString:@"1"]) {
        
        int x = self.count-self.head;//4-5=-1
        
        if (x<0) {
            _pageSmallMax = 1;
            return _pageSmallMax;
        }
        
        int h = 1;
        int wanzhengPage  = x/bigCount*2;//0
        int z = 0;
        int yushu = x%bigCount;
        if (yushu == 0) {
            
        }else if (yushu<=_pageCount1) {
            z++;
        }else {
            z+=2;
        }
        
        _pageSmallMax = h+wanzhengPage+z;
        
    }
    else {
        int wanzhengPage  = self.count/bigCount*2;//15/15*2=2
        int yushu = self.count%bigCount;
        int z = 0;
        if (yushu == 0 && wanzhengPage ==0) {
            z++;
        }
        else if (yushu == 0) {
            
        }
        else if (yushu<=_pageCount1) {
            z++;
        }else {
            z+=2;
        }
        _pageSmallMax = wanzhengPage+z;
    }
    return _pageSmallMax;
}

- (int)pageBigMaxWithCount:(int)count {
    int bigCount = self.pageCount1+self.pageCount2;//15
    if ([self.has_head isEqualToString:@"1"]) {
        
        int x = self.count-self.head;//1
        
        if (x<0) {
            _pageBigMax = 1;
            return _pageBigMax;
        }
        
        int h = 1;
        int wanzhengPage  = x/bigCount;//0
        int z = 0;
        int yushu = x%bigCount;
        if (yushu > 0) {
            z++;
        }
        
        _pageBigMax = h+wanzhengPage+z;
    }
    else {
        int wanzhengPage  = self.count/bigCount;//15/15*2=2
        int yushu = self.count%bigCount;
        int z = 0;
        if (yushu == 0 && wanzhengPage ==0) {
            z++;
        }else if (yushu>0) {
            z++;
        }
        _pageBigMax = wanzhengPage+z;
    }
   
    return _pageBigMax;
}



- (void)setCount:(int)count{
    _count = count;
    [self pageSmallMaxWithCount:_count];
    [self pageBigMaxWithCount:_count];
}

@end
