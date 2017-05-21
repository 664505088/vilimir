//
//  XYAlbumCell.m
//  IHome
//
//  Created by YuanLe on 14-3-12.
//  Copyright (c) 2014年 ihome86. All rights reserved.
//

#import "XYAlbumCell.h"
#import "XYFactory.h"
@implementation XYAlbumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.xImageView = [XYFactory createImageViewWithFrame:CGRectMake(10, 10, 60, 60) Image:nil];
        self.xTitleLabel = [XYFactory createLabelWithFrame:CGRectMake(80, 20, 220, 25) Text:@"xxxx" Font:15];
        self.xSubTitleLabel = [XYFactory createLabelWithFrame:CGRectMake(80, 45, 220, 15) Text:@"xxxx" Color:[UIColor grayColor] Font:12];
        
        _xImageView.layer.cornerRadius = 8;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:[XYFactory createViewWithFrame:CGRectMake(0, 79, H_WIDTH, 0.5) color:[UIColor grayColor]]];
        
        [self.contentView addSubview:_xImageView];
        [self.contentView addSubview:_xTitleLabel];
        [self.contentView addSubview:_xSubTitleLabel];
    }
    return self;
}



@end
