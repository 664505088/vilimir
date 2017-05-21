//
//  XYNewsDetailHeadCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-9.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsDetailHeadCell.h"

@implementation XYNewsDetailHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = NEWSDETAIL_TITLE_FONT;
        [self.contentView addSubview:_titleLabel];
        
        self.create_timeLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:NEWSDETAIL_SUBTITLE_FONT];
        [self.contentView addSubview:_create_timeLabel];
    
        
        
        
        self.imgView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        _imgView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imgView];
        
        
    }
    return self;
}


- (void)setNewsDetail:(MDNewsDetail *)newsDetail {
    if (_newsDetail != newsDetail) {
        _newsDetail = newsDetail;
        
        //标题
        if (_newsDetail.title) {
            self.titleLabel.text = _newsDetail.title;
        }
        
        //来源
        NSString * createTime = nil;
        if (_newsDetail.create_time) {
            createTime = _newsDetail.create_time;
        }
        if (_newsDetail.channels) {
            if (createTime == nil) {
                createTime = [NSString stringWithFormat:@"来源:%@",_newsDetail.channels];
            }else {
                createTime = [createTime stringByAppendingFormat:@"  来源:%@",_newsDetail.channels];
            }
        }
        if (createTime) {
            self.create_timeLabel.text = createTime;
        }
        
        
        if (_newsDetail.images.count > 0) {
            for (int i=0; i<_newsDetail.images.count; i++) {
//                NSString * url = [_newsDetail.images objectAtIndex:i];
            
            [_imgView setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/0eb30f2442a7d9335c4e829caf4bd11372f0017e.jpg"]];
//                [_imgView setImageWithURL:[NSURL URLWithString:url]];
                break;
            }
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    float y = NEWSDETAIL_GAP_V;
//    265/195
    if (self.newsDetail.title) {
        self.titleLabel.frame = CGRectMake(NEWSDETAIL_GAP_H, y, NEWSDETAIL_WIDTH, self.h1);
        y+=self.h1;
    }
    
    if (self.newsDetail.create_time || self.newsDetail.channels) {
        self.create_timeLabel.frame = CGRectMake(NEWSDETAIL_GAP_H, y, NEWSDETAIL_WIDTH, self.h2);
        y+=self.h2;
    }
    
    if (self.newsDetail.images.count>0) {
        self.imgView.frame = CGRectMake(NEWSDETAIL_GAP_H, y, NEWSDETAIL_WIDTH, self.h3);
        y+=self.h3;
    }
    self.leftLabel.frame = CGRectMake(NEWSDETAIL_GAP_H, y, NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-y);
}

@end
