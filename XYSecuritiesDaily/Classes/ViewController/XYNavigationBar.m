//
//  XYNavigationBar.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNavigationBar.h"

@implementation XYNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImageView = [XYFactory createImageViewWithFrame:CGRectMake(self.bounds.size.width-580, self.bounds.size.height-57, 139.5, 45) Image:@"icon_logo"];
        [self addSubview:_logoImageView];
        
        self.items = [[NSMutableArray alloc] init];
        
        NSArray * img1 = @[@"icon_edit_1",@"icon_headImage_1",@"icon_refresh_1"];
        NSArray * img2 = @[@"icon_edit_2",@"icon_headImage_2",@"icon_refresh_2"];
        for (int i=0; i<3; i++) {
            UIButton * button = [XYFactory createButtonWithFrame:CGRectMake(self.bounds.size.width-10-(3-i)*(65), self.bounds.size.height-30-16.5, 30, 30) Image:img1[i] Image:img2[i]];
            [self addSubview:button];
            button.tag = i;
            [_items addObject:button];
        }

    }
    return self;
}



@end
