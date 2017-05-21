//
//  XYShareView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYShareView.h"

@implementation XYShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //登录视图背景
        UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.bounds Image:@"info_bg1"];
        [self addSubview:loginBg];
        
        UILabel * titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 15, self.bounds.size.width, 25) Text:@"分享" Color:nil Font:19 textAlignment:1];
        [self addSubview:titleLabel];
        
        float width = self.bounds.size.width;
        
        NSArray * title = @[@"新浪微博",@"腾讯微博",@"网易微博",@"微信好友",@"朋友圈分享"];
        self.buttons = [[NSMutableArray alloc] init];
        self.labels = [[NSMutableArray alloc] init];
        for (int i=0; i<3; i++) {
            for (int j=0; j<2; j++) {
                if (i*2+j <5) {
                    float x = j*(width-200-80+100)+40;
                    float y = 80+i*140;
                    
                    UIButton * button = [XYFactory
        createButtonWithFrame:CGRectMake(x+12, y, 75, 75)
        Image:[NSString stringWithFormat:@"edit_icon_%d",i*2+j+1]
        Image:[NSString stringWithFormat:@"edit_icon_%ds",i*2+j+1]];
                    [self addSubview:button];
                    

                    UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(x, y+75, 100, 25) Text:title[i*2+j] Color:nil Font:17 textAlignment:1];
                    [self addSubview:label];
                    

                    [_buttons addObject:button];
                    [_labels addObject:label];

                }
            }
        }
    }
    return self;
}



@end
