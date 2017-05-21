//
//  XYQuiltViewCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-27.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYQuiltViewCell.h"

@implementation XYQuiltViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //黑框
        _backgroundView = [XYFactory createViewWithFrame:CGRectZero color:nil];
        [self addSubview:_backgroundView];
        _backgroundView.layer.borderColor = COLOR_RGB(220, 220, 220).CGColor;
        _backgroundView.layer.borderWidth = 1.f;
        
        
        //图片灰底
        _grayView =  [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(170, 170, 170)];
        [_backgroundView addSubview:_grayView];
        
        //默认logo
        _normalImageView = [XYFactory createImageViewWithFrame:CGRectMake(0, 0, 138, 45) Image:@"image_normal"];
        [_grayView addSubview:_normalImageView];
        
        //图片
        self.imageView = [XYFactory createImageViewWithFrame:CGRectZero
                                                       Image:nil];
        [_backgroundView addSubview:_imageView];
        
        
        //文字背景
        _grayTitleBg = [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(239, 239, 239)];
        [_backgroundView addSubview:_grayTitleBg];
        
        //文字
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero
                                                     Text:nil
                                                    Color:COLOR_RGB(150, 150, 150)
                                                     Font:24
                                            textAlignment:0];
        [_backgroundView addSubview:_titleLabel];
    

        
//        self.backgroundColor = [UIColor greenColor];
//        _titleLabel.backgroundColor = [UIColor purpleColor];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    //cell间距=5;
    float g = 5;
    float x = (width-QUILT_BG_WIDTH)/2.0;
    float y = (QUILT_CELL_GAP_V-g)/2.0;
    
    //黑框
    _backgroundView.frame = CGRectMake(x, y, QUILT_BG_WIDTH, height-y*2);
    
    //图片
    float imageHeight = [XYQuiltViewCell imageHeightWithImage:self.image];
    _imageView.frame = CGRectMake(QUILT_GAP, QUILT_GAP, QUILT_BG_WIDTH-QUILT_GAP*2.0, imageHeight-QUILT_GAP*2);
    _grayView.frame = _imageView.frame;
    _normalImageView.center = CGPointMake(_grayView.bounds.size.width/2, _grayView.bounds.size.height/2.0);

//    
    //title背景
    float titleHeight = [XYQuiltViewCell titleHeightWithImage:self.image];
    _grayTitleBg.frame = CGRectMake(1, imageHeight-QUILT_GAP*2, QUILT_BG_WIDTH-2, height-y*2-imageHeight+QUILT_GAP*2);
    
    _titleLabel.frame = CGRectMake(QUILT_TITLE_GAP, imageHeight+QUILT_TITLE_GAP-QUILT_GAP, QUILT_BG_WIDTH-QUILT_TITLE_GAP*2, titleHeight);
}

- (void)setImage:(MDImage *)image {
    if (_image != image) {
        _image = image;
        if (_image.descript != nil && ![_image.descript isEqualToString:@""]) {
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.font = [UIFont systemFontOfSize:20];
            self.titleLabel.text = [NSString stringWithFormat:@"  %@",_image.descript];
        }else if (_image.listName) {
            self.titleLabel.numberOfLines = 1;
            self.titleLabel.font = [UIFont systemFontOfSize:24];
            self.titleLabel.text = [NSString stringWithFormat:@"%@",_image.listName];
        }
        if (_image.img_url) {
            [self.imageView setImageWithURL:[NSURL URLWithString:_image.img_url]];
        } 
    }
    
  
}



+ (float)imageHeightWithImage:(MDImage*)image {
    float w = QUILT_BG_WIDTH;
    float width = [image.width floatValue];
    float height = [image.height floatValue];
    
    height = height>0?height:100;
    width = width>0?width:200;

    return w/(width/height);
}
+ (float)titleHeightWithImage:(MDImage*)image {
    if (image.descript) {
        NSString * str = [NSString stringWithFormat:@"  %@",image.descript];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(QUILT_BG_WIDTH-QUILT_TITLE_GAP*2, 10000)];
        return size.height;
    }else {
        return QUILT_TITLE_HEIGHT;
    }
}
+ (float)cellHeightWithImage:(MDImage*)image {
    float width = [image.width floatValue];
    float height = [image.height floatValue];
    height = height>0?height:100;
    width = width>0?width:200;
    
    float imageHeight = [self imageHeightWithImage:image];
    float titleHeight = [self titleHeightWithImage:image];

    return imageHeight+titleHeight+QUILT_CELL_GAP_V-5+QUILT_TITLE_GAP*2;
}



@end
