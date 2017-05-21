//
//  XYUserInfoView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYUserInfoView.h"

@implementation XYUserInfoView

- (void)dealloc {
    [self.toolButtons removeAllObjects];
    self.toolButtons = nil;
    
    [self.rightButton removeFromSuperview];
    self.rightButton = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * redactBg = [XYFactory createImageViewWithFrame:self.bounds Image:@"info_bg2"];
        [self addSubview:redactBg];
        
        
        //忘记密码按钮
        self.rightButton = [XYFactory createButtonWithFrame:CGRectMake(240, 12, 89, 30) Image:@"info_button_forget1" Image:@"info_button_forget2"];
        [self addSubview:_rightButton];
        
        UILabel * rightButtonText = [XYFactory createLabelWithFrame:_rightButton.bounds Text:@"编辑" Color:COLOR_RGB(146,154,155) Font:17 textAlignment:1];
        rightButtonText.tag = SUB_VIEW_TAG;
        [_rightButton addSubview:rightButtonText];
        
        
        
        
        NSArray * imageArray = @[@"info_gentie",@"info_shoucang",@"info_xiaoxi"];
        NSArray * titleArray = @[@"我的跟帖",@"我的收藏",@"我的消息"];
        self.toolButtons = [[NSMutableArray alloc] init];
        for (int i=0; i<3; i++) {
            UIButton * button = [XYFactory createButtonWithFrame:CGRectMake(30+i*110, 433, 60, 53) Image:nil];
            //        button.backgroundColor = [UIColor redColor];
            [self addSubview:button];
            [_toolButtons addObject:button];
            
            NSString *imageName1 = [imageArray[i] stringByAppendingString:@"1"];
            NSString *imageName2 = [imageArray[i] stringByAppendingString:@"2"];
            UIImageView * iconImageView = [XYFactory createImageViewWithFrame:CGRectMake(15, 3.5, 30, 30) Image:imageName1];
            iconImageView.highlightedImage = [UIImage imageNamed:imageName2];
            iconImageView.tag = SUB_VIEW_TAG;
            [button addSubview:iconImageView];
            
            UILabel * titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 33, 60, 20) Text:titleArray[i] Color:[UIColor whiteColor] Font:14 textAlignment:1];
            iconImageView.tag = SUB_VIEW_TAG+1;
            [button addSubview:titleLabel];
        }
        
        
        self.imageView = [XYFactory createImageViewWithFrame:CGRectMake(130, 74.5, 80, 80) Image:@"info_touxiang"];
        [self addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 40;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.nameLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 185, 240, 25) Text:nil Color:COLOR_RGB(32, 34, 34) Font:20 textAlignment:1];
        [self addSubview:_nameLabel];
        
        self.phoneLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 240, 240, 25) Text:nil Color:COLOR_RGB(32, 34, 34) Font:20 textAlignment:1];
        [self addSubview:_phoneLabel];
        
        self.mailLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 295, 240, 25) Text:nil Color:COLOR_RGB(32, 34, 34) Font:20 textAlignment:1];
        [self addSubview:_mailLabel];
    }
    return self;
}



@end
