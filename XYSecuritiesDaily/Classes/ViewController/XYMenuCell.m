//
//  XYMenuCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYMenuCell.h"

@implementation XYMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
        UIImageView *selectedView = [XYFactory createImageViewWithFrame:CGRectZero Image:@"menu_selected"];
        self.selectedBackgroundView = selectedView;
        
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero
                                                     Text:@"title"
                                                    Color:[UIColor whiteColor]
                                                     Font:37/2.0
                                            textAlignment:1];
        _titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:37/2.0];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float height = self.contentView.bounds.size.height;
    float width = self.contentView.bounds.size.width;
    self.titleLabel.frame = CGRectMake(5, 0, width-5, height);
    self.titleLabel.backgroundColor = [UIColor clearColor];
}

@end
