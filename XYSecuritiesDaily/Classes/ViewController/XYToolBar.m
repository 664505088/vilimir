//
//  XYToolBar.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYToolBar.h"

@implementation XYToolBar

- (void)dealloc {
    [self.items removeAllObjects];
    self.items = nil;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.items = [[NSMutableArray alloc] init];
        for (int i=0; i<5; i++) {
            UIButton * btn = [XYFactory createButtonWithFrame:CGRectMake(40+65*i, 9.5, 30, 30) Image:[NSString stringWithFormat:@"news_tool%d1",i+1] Image:[NSString stringWithFormat:@"news_tool%d2",i+1]];
            [self addSubview:btn];
            btn.tag = i;
            [_items addObject:btn];
        }

    }
    return self;
}



@end
