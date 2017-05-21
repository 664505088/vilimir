//
//  XYQuiltCollectCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYQuiltCollectCell.h"

@implementation XYQuiltCollectCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:nil Font:25 textAlignment:1];
        [self addSubview:_titleLabel];
        
        self.imageView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    float height = self.bounds.size.height;
    float width = self.bounds.size.width;
    NSLog(@"%.f %.f",width,height);
    self.titleLabel.frame = CGRectMake(20, 5, width-40, 35);
    self.imageView.frame = CGRectMake(20, 40, width-40, height-70);

}


@end
