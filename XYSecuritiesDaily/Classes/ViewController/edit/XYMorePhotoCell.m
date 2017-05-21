//
//  XYMorePhotoCell.m
//  IHome
//
//  Created by YuanLe on 14-3-11.
//  Copyright (c) 2014年 ihome86. All rights reserved.
//

#import "XYMorePhotoCell.h"
#import "XYFactory.h"
@implementation XYMorePhotoCell

//initWithReuseIdentifier
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.imageView = [XYFactory createImageViewWithCornerRadius:5];
        [self addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    self.imageView.frame = CGRectMake(5, 5, width-10, height-10);
}

@end
