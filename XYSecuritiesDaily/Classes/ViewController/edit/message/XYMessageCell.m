//
//  XYMessageCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYMessageCell.h"

@implementation XYMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIColor *color = COLOR_RGB(56, 56, 56);
        

        self.bgView = [XYFactory createViewWithFrame:CGRectZero color:nil];
        [self.contentView addSubview:_bgView];
        
        UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(110, 20, 200, 25) Text:@"内容消息:" Color:color Font:20];
        [self.bgView addSubview:label];
        
        _lineView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        _lineView.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self.contentView addSubview:_lineView];
        
        self.descriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:22];
        [_bgView addSubview:_descriptLabel];
        _descriptLabel.numberOfLines = 0;
        
        self.dateLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:15 textAlignment:2];
        [_bgView addSubview:_dateLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    _lineView.frame = CGRectMake(110, height-1.5, width-180, 1);
    
    float x = self.leftMove?-80:0;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.frame = CGRectMake(x, 0, width, height);
    } completion:nil];
    self.descriptLabel.frame = CGRectMake(110, 50, 740, height-90);
    self.dateLabel.frame = CGRectMake(850, height-40, 100, 20);
}




- (void)setMessage:(MDMessage *)message {
    if (message.create_time) {
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        if (message.create_time.length == 19) {
            NSDate * history = [f dateFromString:message.create_time];
            NSTimeInterval a = [history timeIntervalSinceNow];
            int house = -a/60/60;
            f.dateFormat = house>24?@"yyyy-MM-dd":@"HH:mm:ss";
            self.dateLabel.text = [f stringFromDate:history];
        }else {
            self.dateLabel.text = message.create_time;
        }
    }
   
    if (message.message) {
        self.descriptLabel.text = message.message;
    }
}

@end
