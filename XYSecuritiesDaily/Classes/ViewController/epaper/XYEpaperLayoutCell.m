//
//  XYEpaperLayoutCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperLayoutCell.h"

@implementation XYEpaperLayoutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        normal_bg1 = [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(170, 170, 170)];
        [self.contentView addSubview:normal_bg1];
        
        normal_bg2 = [XYFactory createImageViewWithFrame:CGRectMake(0, 0, 138, 45) Image:@"image_normal"];
        [normal_bg1 addSubview:normal_bg2];
        
        self.imgView = [XYFactory createImageViewWithCornerRadius:2];
        [self.contentView addSubview:_imgView];
        _imgView.contentMode = UIViewContentModeTop;
//        _imgView.clipsToBounds = YES;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.height;
    float height = self.bounds.size.width;
//    350x550
    normal_bg1.frame = CGRectMake((width-350)/2, (height-550)/2, 350, 550);
    _imgView.frame = normal_bg1.frame;
    normal_bg2.center = CGPointMake(350.0/2, 550.0/2);
    
}
@end
