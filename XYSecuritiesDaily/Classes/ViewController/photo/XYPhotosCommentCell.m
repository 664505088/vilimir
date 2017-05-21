//
//  XYPhotosCommentCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-25.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPhotosCommentCell.h"

@implementation XYPhotosCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIColor *graycolor = COLOR_RGB(140, 140, 140);
        
        self.bgView = [XYFactory createViewWithFrame:CGRectZero color:nil];
        [self.contentView addSubview:_bgView];
        _bgView.layer.borderColor = [UIColor grayColor].CGColor;
        _bgView.layer.borderWidth = 1;
        
        
        self.userLabel = [XYFactory createLabelWithFrame:CGRectMake(25, 15, 600, 25) Text:nil Color:graycolor Font:25];
        [_bgView addSubview:_userLabel];
        
        self.dateLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:[UIColor grayColor] Font:15 textAlignment:2];
        [_bgView addSubview:_dateLabel];
        
        self.descriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:22];
        [_bgView addSubview:_descriptLabel];
        _descriptLabel.numberOfLines = 0;
        
        
        
        //来源用户
        self.fromView = [XYFactory createViewWithFrame:CGRectZero color:COLOR_RGB(233, 233, 233)];
        [_bgView addSubview:_fromView];
        _fromView.layer.borderColor = COLOR_RGB(223, 223, 223).CGColor;
        _fromView.layer.borderWidth = 1;
        
        
        self.fromUserLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Font:25];
        [_fromView addSubview:_fromUserLabel];
        
        self.fromDescriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:nil Color:graycolor Font:22];
        _fromDescriptLabel.numberOfLines = 0;
        [_fromView addSubview:_fromDescriptLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float w = width-50;
    float h = height-10;
    
    self.bgView.frame = CGRectMake(0, 5, width, h);
    
    self.dateLabel.frame = CGRectMake(w-210, 20, 180, 20);
    
    //15 25 5+(0)+5 h(5) 15
    //15 25  5+h(5) 20
    
    if (self.isHasFromUser) {//如果有来源
        self.fromView.hidden = NO;
        CGSize size = [self.fromDescriptLabel.text sizeWithFont:_fromDescriptLabel.font constrainedToSize:CGSizeMake(w-50, 10000)];
        self.fromView.frame = CGRectMake(25, 50, w, size.height+65);
        self.fromUserLabel.frame = CGRectMake(25, 15, w-50, 25);
        self.fromDescriptLabel.frame = CGRectMake(25, 45, w-50, size.height+5);
        
        self.descriptLabel.frame = CGRectMake(20, 50+size.height+65, width-40, h-(size.height+65)-45-15);
    }else {
        self.fromView.hidden = YES;
        self.descriptLabel.frame = CGRectMake(20, 45, width-40, h-65);
    }
}

+ (float)heightWithAString:(NSString*)aStr
             isHasFromUser:(BOOL)isHas
                   BString:(NSString*)bStr {
    if (aStr == nil) {
        aStr = @"";
    }
    if (bStr == nil) {
        bStr = @"";
    }
    
    float width = 850;
    float w = width-50;
    //15 25 5+(0)+5 h(5) 15
    CGSize s = [aStr sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(width-40, 10000)];
    float hd1 = s.height+5;
    float h1 = 45+hd1+20;
    
    
    float h2 = 0;
    if (isHas) {//如果有来源
        //15 25  5+h(5)+5 10
        CGSize size = [bStr sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(w-50, 10000)];
        float hd2 = size.height+5;
        h2 = 45+hd2+20;
    }
    return h1+h2;
}



- (void)setComment:(MDComment *)comment {
    if (comment.user_name) {
        self.userLabel.text = comment.user_name;
    }
    if (comment.content) {
        self.descriptLabel.text = comment.content;
    }
    
    if (comment.create_time) {
        self.dateLabel.text = comment.create_time;
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
    
    
    
}

@end
