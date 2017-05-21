//
//  XYNewItemView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewItemView.h"

@implementation XYNewItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor grayColor];
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 0, frame.size.width, 75) Text:@"title" Color:nil Font:-1];
        [self addSubview:_titleLabel];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        self.normal_bg1 = [XYFactory createViewWithFrame:CGRectMake(0, 75, 191, 267/2.0) color:COLOR_RGB(170, 170, 170)];
        [self addSubview:_normal_bg1];
        
        self.normal_bg2 = [XYFactory createImageViewWithFrame:CGRectMake(0, 0, 138, 45) Image:@"image_normal"];
        _normal_bg2.center = CGPointMake(191/2.0, 267/4.0);
        [_normal_bg1 addSubview:_normal_bg2];
        
        self.imageView = [XYFactory createImageViewWithFrame:CGRectMake(0, 75, 191, 267/2.0) Image:nil];
        [self addSubview:_imageView];
        _imageView.layer.name = @"white";
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
        self.subTitleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 50+267/2.0+14, frame.size.width, frame.size.height-(55+267/2.0+14)) Text:@"subTitleLabel" Color:COLOR_RGB(103, 103, 103) Font:-1];
        _subTitleLabel.numberOfLines = 3;
        _subTitleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self addSubview:_subTitleLabel];
        
        
        ;
        _titleLabel.font = FONT_BOLD(30);
        _titleLabel.textColor = COLOR_RGB(20, 20, 20);
        _subTitleLabel.font = FONT_BOLD(21);
    }
    return self;
}

- (void)setNews:(MDNews*)news {
    self.normal_bg1.hidden = self.imageView.hidden;
    if (self.imageView.hidden) {
        self.normal_bg1.frame = self.imageView.frame;
    }
    if (news.shot_title != nil && ![news.shot_title isEqualToString:@""]) {
        _titleLabel.text = news.shot_title;
        [_titleLabel textToTit];
        
    }else if (news.title) {
        _titleLabel.text = news.title;
        [_titleLabel textToTit];

    }
    [_titleLabel sizeToFit];
    if (news.content_summary) {
        _subTitleLabel.text = news.content_summary;
        [_subTitleLabel textToTit];

        [_subTitleLabel sizeToFit];
    }
    if (news.title_img) {
        _imageView.backgroundColor = [UIColor clearColor];
        [_imageView setImageWithURL:[NSURL URLWithString:news.title_img]];
    }
}

@end
