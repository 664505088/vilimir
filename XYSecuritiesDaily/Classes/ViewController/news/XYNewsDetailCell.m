//
//  XYNewsDetailCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-9.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsDetailCell.h"

@implementation XYNewsDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        XYEditManager * editManager = [XYEditManager shardManager];
        
//        CGRectMake(NEWSDETAIL_GAP_H, NEWSDETAIL_GAP_V, NEWSDETAIL_WIDTH, 20)
        self.leftLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:editManager.fontSize];
        [self.contentView addSubview:_leftLabel];
        _leftLabel.numberOfLines = 0;
        
        
//        CGRectMake(NEWSDETAIL_GAP_H, NEWSDETAIL_GAP_V, NEWSDETAIL_WIDTH, 20)
        self.rightLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:editManager.fontSize];
        [self.contentView addSubview:_rightLabel];
        _rightLabel.numberOfLines = 0;
        
//        _rightLabel.backgroundColor = _leftLabel.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.height;
    XYEditManager * editManager = [XYEditManager shardManager];
    _leftLabel.font = _rightLabel.font = [UIFont systemFontOfSize:editManager.fontSize];
    
    _leftLabel.frame = CGRectMake(NEWSDETAIL_GAP_H, NEWSDETAIL_GAP_V, NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-NEWSDETAIL_GAP_V);
    _rightLabel.frame = CGRectMake(width-NEWSDETAIL_GAP_H-NEWSDETAIL_WIDTH, NEWSDETAIL_GAP_V, NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-NEWSDETAIL_GAP_V);
    [_leftLabel  sizeToFit];
    [_rightLabel sizeToFit];
}

@end
