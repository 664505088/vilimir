//
//  XYCommentCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYCommentCell.h"

@implementation XYCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIColor *graycolor = COLOR_RGB(140, 140, 140);
        
        _lineView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        _lineView.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self.contentView addSubview:_lineView];
        
        
        self.bgView = [XYFactory createViewWithFrame:CGRectZero color:nil];
        [self.contentView addSubview:_bgView];

        
        ///显示"跟帖内容"字符
        UILabel * gentieLabel = [XYFactory createLabelWithFrame:CGRectMake(110, 25, 600, 25) Text:@"跟帖内容" Color:graycolor Font:19];
        [_bgView addSubview:gentieLabel];
        
        //跟帖状态
        self.statusLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor whiteColor] Font:15 textAlignment:1];
        [_bgView addSubview:_statusLabel];

        
        
        //显示内容
        self.descriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:-1];
        [_bgView addSubview:_descriptLabel];
        _descriptLabel.numberOfLines = 0;
        _descriptLabel.font = MDCOMMENT_FONT_MY_descript;
        
        //原文标题
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:nil Font:-1];
        _titleLabel.numberOfLines = 0;
        [_bgView addSubview:_titleLabel];
        _titleLabel.font = MDCOMMENT_FONT_MY_title;
        
        //时间
        self.dateLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:15 textAlignment:2];
        [_bgView addSubview:_dateLabel];
        
        
        
        
        
        //来源用户
        self.fromView = [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(233, 233, 233)];
        [_bgView addSubview:_fromView];
        _fromView.layer.borderColor = COLOR_RGB(223, 223, 223).CGColor;
        _fromView.layer.borderWidth = 1;
        
        
        //来源用户
        self.fromUserLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:-1];
        [_fromView addSubview:_fromUserLabel];
        _fromUserLabel.font = MDCOMMENT_FONT_MY_fromUser;
        
        //用户评论
        self.fromDescriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:graycolor Font:-1];
        _fromDescriptLabel.numberOfLines = 0;
        [_fromView addSubview:_fromDescriptLabel];
        _fromDescriptLabel.font = MDCOMMENT_FONT_MY_fromDescript;
        
 
        
//        _descriptLabel.backgroundColor = [UIColor greenColor];
//        _titleLabel.backgroundColor = [UIColor yellowColor];
//        gentieLabel.backgroundColor = [UIColor blueColor];
//        _dateLabel.backgroundColor = [UIColor orangeColor];
//        _fromUserLabel.backgroundColor = [UIColor purpleColor];
//        _fromDescriptLabel.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float w = width-220;
    float gap = 5;//间隔
    self.bgView.frame = CGRectMake(0, 0, width, height);
    _lineView.frame = CGRectMake(110, height-2, w, 1);
    
    CGSize s = [_statusLabel.text sizeWithFont:_statusLabel.font constrainedToSize:CGSizeMake(w, 50)];
    s.width+=10;
    s.height+=5;
    _statusLabel.frame = CGRectMake(width-s.width-110, 25, s.width, s.height+5);
    _statusLabel.layer.cornerRadius = s.height/4;
    float y = 50;
    if (self.descriptLabel.text) {
        y+=gap;
        CGSize size = [_descriptLabel.text sizeWithFont:_descriptLabel.font constrainedToSize:CGSizeMake(w, 1000)];
        self.descriptLabel.frame = CGRectMake(110, y, width-220, size.height);
        y+=size.height;

    }
    self.fromView.hidden = !_isHasFromUser;
    
    if (self.isHasFromUser) {
        y+=gap;
        self.fromView.hidden = NO;
        float from_w = w-50-50;
        
        float h1,h2 = 0;
        if (self.fromUserLabel.text) {
            CGSize size1 = [self.fromUserLabel.text sizeWithFont:_fromUserLabel.font constrainedToSize:CGSizeMake(from_w, 1000)];
            
            self.fromUserLabel.frame = CGRectMake(25, gap, from_w, size1.height);
            h1 = size1.height+gap;
        }
        if (self.fromDescriptLabel.text) {
            CGSize size2 = [self.fromDescriptLabel.text sizeWithFont:_fromDescriptLabel.font constrainedToSize:CGSizeMake(from_w, 1000)];
            self.fromDescriptLabel.frame = CGRectMake(25, gap+h1, from_w, size2.height);
            h2 = size2.height+gap;
        }
        
        self.fromView.frame = CGRectMake(110+25, y, w-50, h1+h2+gap);
        
        y+=(h1+h2+gap);
    }
    y+=gap;
    CGSize size = [self.titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(w, 1000)];
    self.titleLabel.frame = CGRectMake(110, y, width-220, size.height);
    y+=size.height;
    y+=gap;
    self.dateLabel.frame = CGRectMake(width-110-130, y, 130, 20);
}



+ (float)heightWithDescript:(NSString *)descript
                      title:(NSString *)title
              isHasFromUser:(BOOL)isHas
                  from_user:(NSString *)from_user
              from_descript:(NSString *)from_descript {
    float width = 1024;
    float w = width-220;
    float gap = 5;//间隔
    float y = 50;
    if (descript) {
        y+=gap;
        CGSize size = [descript sizeWithFont:MDCOMMENT_FONT_MY_descript constrainedToSize:CGSizeMake(w, 1000)];
        y+=size.height;
    }
    
    if (isHas) {
        y+=gap;
        float from_w = w-50-50;
        
        float h1,h2 = 0;
        if (from_user) {
            CGSize size1 = [from_user sizeWithFont:MDCOMMENT_FONT_MY_fromUser constrainedToSize:CGSizeMake(from_w, 1000)];
            h1 = size1.height+gap;
        }
        if (from_descript) {
            CGSize size2 = [from_descript sizeWithFont:MDCOMMENT_FONT_MY_fromDescript constrainedToSize:CGSizeMake(from_w, 1000)];
            h2 = size2.height+gap;
        }
        y+=(h1+h2+gap);
    }
    y+=gap;
    CGSize size = [[NSString stringWithFormat:@"原文标题:%@",title] sizeWithFont:MDCOMMENT_FONT_MY_title constrainedToSize:CGSizeMake(w, 1000)];
    y+=size.height;
    y+=gap;
    y+=20;//+时间高度
    y+=25;//底和线的间隔
    return y;
}




- (void)setComment:(MDComment *)comment {
    //未审未发布
    if ([comment.status isEqualToString:@"1"]) {
        self.statusLabel.text = @"未通过审核";
        _statusLabel.backgroundColor = [UIColor grayColor];
    }
    //未审核已经发布
//    if ([comment.status isEqualToString:@"0"]) {
//        self.statusLabel.text = @"未审核已经发布";
//        _statusLabel.backgroundColor = [UIColor blueColor];
//    }
//
//    //通过审核
//    else if ([comment.status isEqualToString:@"2"]) {
//        self.statusLabel.text = @"通过审核";
//        _statusLabel.backgroundColor = [UIColor greenColor];
//    }
//    //已经删除
//    else if ([comment.status isEqualToString:@"3"]) {
//        self.statusLabel.text = @"评论已经删除";
//        _statusLabel.backgroundColor = [UIColor redColor];
//    }else if (comment.from_id==nil && comment.column_id==nil){
//        self.statusLabel.text = @"新闻已被删除";
//        _statusLabel.backgroundColor = [UIColor grayColor];
//    }
    
    
    if (comment.content) {
        self.descriptLabel.text = comment.content;
    }
    
    if (comment.create_time) {
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        
        if (comment.create_time.length >= 19) {
            f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate * history = [f dateFromString:comment.create_time];
            if (history==nil) {
                f.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
                history = [f dateFromString:comment.create_time];
            }
            NSTimeInterval a = [history timeIntervalSinceNow];
            int house = -a/60/60;
            f.dateFormat = house>24?@"yyyy-MM-dd":@"HH:mm:ss";
            self.dateLabel.text = [f stringFromDate:history];
        }else {
            self.dateLabel.text = comment.create_time;
        }
    }
    
    if (comment.parent_content || comment.parent_user_name) {
        self.isHasFromUser = YES;
        if (comment.parent_content) {
            self.fromDescriptLabel.text = comment.parent_content;
        }
        if (comment.parent_user_name) {
            self.fromUserLabel.text = comment.parent_user_name;
        }
    }else {
        self.isHasFromUser = NO;
    }
    
    if (comment.news_title) {
        self.titleLabel.text = [NSString stringWithFormat:@"原文标题:%@",comment.news_title];
    }
    
}

@end
