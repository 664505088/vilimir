//
//  XYNewsCollectCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsCollectCell.h"

@implementation XYNewsCollectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
        
        self.bgView = [XYFactory createViewWithFrame:CGRectZero color:nil];
        [self.contentView addSubview:_bgView];
        
        
        _lineView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        _lineView.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self.contentView addSubview:_lineView];
        
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:22];
        [_bgView addSubview:_titleLabel];
        
        self.subTitleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:15 textAlignment:2];
        [_bgView addSubview:_subTitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    _lineView.frame = CGRectMake(110, height-1, width-180, 1);
    
    float x = self.leftMove?-80:0;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.frame = CGRectMake(x, 0, width, height);
    } completion:nil];
    
    self.titleLabel.frame = CGRectMake(110, (height-35)/2, 740, 35);
    self.subTitleLabel.frame = CGRectMake(850, 45, 100, 25);
}

//- (void)setLeftMove:(BOOL)leftMove {
//    _leftMove = leftMove;
//    [self ];
//}

- (void)setCollect:(MDCollect *)collect {
    if (collect.title) {
        self.titleLabel.text = collect.title;
    }else if (collect.descript) {
        self.titleLabel.text = collect.descript;
    }
    if (collect.create_date) {
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        if (collect.create_date.length == 19) {
            NSDate * history = [f dateFromString:collect.create_date];
            NSTimeInterval a = [history timeIntervalSinceNow];
            int house = -a/60/60;
            f.dateFormat = house>24?@"yyyy-MM-dd":@"HH:mm:ss";
            self.subTitleLabel.text = [f stringFromDate:history];
        }else {
            self.subTitleLabel.text = collect.create_date;
        }
    }
}

@end
