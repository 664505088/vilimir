//
//  XYPageControl.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPageControl.h"
#define TAG 10
@implementation XYPageControl



- (void)setIndex:(int)index {
    if (index<_count && index>=0) {
        _index = index;
        float width = self.bounds.size.width;
        float left = (width-((24+11.5)*_count-24))/2;
        for (int i=0; i<_count; i++) {
            UIImageView * imageView = (UIImageView*)[self viewWithTag:TAG+i];
            if (i == index) {
                imageView.highlighted = YES;
                imageView.frame = CGRectMake(left+(11.5+24)*i-2, 0, 15.5, 15);
            }else {
                imageView.highlighted = NO;
                imageView.frame = CGRectMake(left+(11.5+24)*i, 2, 11.5, 11);
            }
        }
        
    }
}

- (void)setCount:(int)count {
    _count = count;
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    float width = self.bounds.size.width;
    float left = (width-((24+11.5)*_count-24))/2;
    for (int i=0; i<_count; i++) {
        
        UIImageView * imageView = [XYFactory createImageViewWithFrame:CGRectMake(left+(11.5+24)*i, 0, 11.5, 11) Image:@"news_head1" Image:@"news_head2"];
        [self addSubview:imageView];
        imageView.tag = i+TAG;
    }
}

@end
