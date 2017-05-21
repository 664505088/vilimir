//
//  XYSmallEpaperCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-2.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYSmallEpaperCell.h"

@implementation XYSmallEpaperCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * o = [XYFactory createViewWithFrame:CGRectMake(20, 28, 8, 8) color:[UIColor blackColor]];
        o.layer.cornerRadius = 4;
//        o.clipsToBounds = YES;
        [self.contentView addSubview:o];
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:20];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.numberOfLines = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    CGSize size = [_titleLabel.text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(width-80, 10000)];
    _titleLabel.frame = CGRectMake(40, 20, size.width, size.height);
}

@end
