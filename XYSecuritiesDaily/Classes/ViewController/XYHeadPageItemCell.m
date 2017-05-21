//
//  XYHeadPageItemCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYHeadPageItemCell.h"

@implementation XYHeadPageItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.transform = CGAffineTransformMakeRotation(1.5707963);
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:-1];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.lineBreakMode = 1;
        _titleLabel.font = FONT_BOLD(25);
        
        
        normal_bg1 = [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(170, 170, 170)];
        [self.contentView addSubview:normal_bg1];
        normal_bg2 = [XYFactory createImageViewWithFrame:CGRectMake(0, 0, 138, 45) Image:@"image_normal"];
        [normal_bg1 addSubview:normal_bg2];
        
        self.headImageView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_headImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];//276x90 138
    
    float width = self.contentView.bounds.size.width;
    float height = self.contentView.bounds.size.height;
    
    
    
    self.titleLabel.frame = CGRectMake(0, 0, width, 42.5);
    normal_bg1.frame = CGRectMake(0, 42.5, width, height-42.5);
    normal_bg2.center = CGPointMake(width/2, (height-42.5)/2);
    self.headImageView.frame = CGRectMake(0, 42.5, width, height-42.5);
//    [self.titleLabel textToFitView];
}
@end
