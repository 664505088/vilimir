//
//  XYQuiltViewCell.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "TMQuiltViewCell.h"

#define QUILT_BG_WIDTH 250   //灰色背景宽度
#define QUILT_GAP 2          //图片与灰色间距
#define QUILT_TITLE_HEIGHT 40   //文字高度
#define QUILT_CELL_GAP_H 50     //左右间隙
#define QUILT_CELL_GAP_V 30     //上下间隙
#define QUILT_TITLE_GAP 10      //标题左右间隙
#define QUILT_TITLE_SPACE @"  "


@interface XYQuiltViewCell : TMQuiltViewCell


{
    UIView *_backgroundView;
    UIView * _grayView;
    UIView * _grayTitleBg;
    UIImageView * _normalImageView;
}

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * titleLabel;

@property(nonatomic, strong) MDImage * image;


+ (float)cellHeightWithImage:(MDImage*)image;
@end
