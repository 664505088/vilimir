//
//  XYNewsPageCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsPageCell.h"


@implementation XYNewsPageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.transform = CGAffineTransformMakeRotation(1.5707963);
        
        
        //所有分割线
        _lineHArray = [[NSMutableArray alloc] init];
        _lineVArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<5; i++) {
            UIImageView * lineH = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
            lineH.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [_lineHArray addObject:lineH];
            [self.contentView addSubview:lineH];
        }
        
        for (int i=0; i<2; i++) {
            UIImageView * lineV = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
            lineV.image = [[UIImage imageNamed:@"news_line_V"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [_lineVArray addObject:lineV];
            [self.contentView addSubview:lineV];
        }
        
        
        
        
        
        self.headPageView = [[XYHeadPageView alloc] initWithFrame:CGRectMake(40.5, 0, 532.5, 587/2.0)];
        [self.contentView addSubview:_headPageView];
        
        
        
        self.subNewsView = [[NSMutableArray alloc] init];
        for (int i=0; i<8; i++) {
            XYNewItemView * newItem = [[XYNewItemView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:newItem];
            newItem.tag = i;
            [_subNewsView addObject:newItem];
            
            UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedNewsItemAtIndex:)];
            newItem.userInteractionEnabled = YES;
            [newItem addGestureRecognizer:gr];
        }
        
    }
    return self;
}

- (void)normalLineFrame {
    for (UIView * v in _lineHArray) {
        v.frame = CGRectZero;
    }
    for (UIView * v in _lineVArray) {
        v.frame = CGRectZero;
    }
}

- (void)setPageArray:(NSArray *)array
           isHasHead:(BOOL)isHasHead
           headArray:(NSArray *)headArray
            delegate:(id)delegate
                 row:(int)row {
    self.delegate = delegate;
    self.headPageView.delegate = delegate;
    self.row = row;
    if (isHasHead == YES) {
        self.headPageView.dataSouth = headArray;
    }
    [self layoutWithCount:array.count hasHead:isHasHead];
    for (int i=0; i<8; i++) {
        XYNewItemView * view = [_subNewsView objectAtIndex:i];
        if (i<array.count) {
            view.hidden = NO;
            MDNews * news = [array objectAtIndex:i];//新闻列表(最多8个)
            [view setNews:news];
        }else {
            view.hidden = YES;
        }
    }
}








- (void)selectedNewsItemAtIndex:(UITapGestureRecognizer*)gr {
    int index = (int)gr.view.tag;
    if ([self.delegate respondsToSelector:@selector(selectedNewsItemAtpage:withIndex:)]) {
        [self.delegate selectedNewsItemAtpage:self.row withIndex:index];
    }
}





///更改视图位置
- (void)layoutWithCount:(NSInteger)count hasHead:(BOOL)isHasHead{
    _headPageView.hidden = YES;
    if (self.row == 0 && isHasHead == YES) {
        _headPageView.hidden = NO;
        [self layoutHeadContextCount:count];
    }
    else {
        if (isHasHead) {
            if (self.row%2 == 1) {//8
                [self layout8ContextContextCount:count];
            }else {//7
                [self layout7ContextContextCount:count];
            }
        }
        else {
            if (self.row%2 == 0) {//8
                [self layout8ContextContextCount:count];
            }else {//7
                [self layout7ContextContextCount:count];
            }
        }
    }
}



- (void)layoutHeadContextCount:(NSInteger)count{
    
//    200/140 100 70 /50 35 /25 17.5 x7/175 125
    float height = NEWSCELL_HEIGHT;
    float h1 = 270;
    float h2 = 170;
    float l = 1;
    float hs = 80;//简介高度
    float iw = 175;//图片宽度
    float ih = 115;//图片高度
    float th = 75;//标题高度
    float gap = (height-h2*3)/2+h2;
    float gap_s2 = (height-h2*3)/4;
    
    int x=0;
    [self normalLineFrame];
    //分割线
    UIView * line1 = [_lineHArray objectAtIndex:x++];//-
    line1.frame = CGRectMake(40, 302, 540, l);
    
    UIView * line2 = [_lineVArray objectAtIndex:0];//|
    line2.frame = CGRectMake(310, 320, l, height-320);
    
    UIView * line3 = [_lineVArray objectAtIndex:1];//|
    line3.frame = CGRectMake(600, 0, l, height);
    
    if (count > 0) {
        XYNewItemView * view = [_subNewsView objectAtIndex:0];
        view.frame = CGRectMake(40.5, height-h1, 250, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, 250, th);
        view.imageView.frame = CGRectMake((250-iw)/2-5, th-5, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, 250, hs);
    }
    
    
    if (count > 1) {
        XYNewItemView * view = [_subNewsView objectAtIndex:1];
        view.frame = CGRectMake(330, height-h1, 250, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, 250, th);
        view.imageView.frame = CGRectMake((250-iw)/2-5, th-5, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, 250, hs);
    }
    
    if (count > 2) {
        XYNewItemView * view = [_subNewsView objectAtIndex:2];
        view.frame = CGRectMake(600+26.5, 0, 280, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 10, 280, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, 280, hs);
    }
    
    if (count > 3) {
        XYNewItemView * view = [_subNewsView objectAtIndex:3];
        view.frame = CGRectMake(600+26.5, gap, 280, 170);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 10, 280, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, 280, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(620, gap-gap_s2, 290, l);
    }
    if (count > 4) {
        XYNewItemView * view = [_subNewsView objectAtIndex:4];
        view.frame = CGRectMake(600+26.5, gap*2, 280, 170);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 10, 280, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, 280, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(620, gap*2-gap_s2, 290, l);
    }
}
- (void)layout8ContextContextCount:(NSInteger)count{
    [self normalLineFrame];
    float height = NEWSCELL_HEIGHT;
    float h1 = 280;
    float h2 = 170;
    float hs = 80;
    float th = 75;
    float l = 1;
    float gap = (height-h2*3)/2+h2;
    float gap_s2 = (height-h2*3)/4;
    float width = 260;
    float iw = 204;
    float ih = 123;
    int x=0;
    if (count > 0) {
        XYNewItemView * view = [_subNewsView objectAtIndex:0];
        view.frame = CGRectMake(41, 0, width, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.imageView.frame = CGRectMake((width-iw)/2-5, th, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, width, hs);
        
        
        UIView * line = [_lineVArray objectAtIndex:0];//|
        line.frame = CGRectMake(width+41+gap_s2, 0, l, height);
    }
    if (count > 1) {
        XYNewItemView * view = [_subNewsView objectAtIndex:1];
        view.frame = CGRectMake(41, height-h1, width, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.imageView.frame = CGRectMake((width-iw)/2-5, th, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(41, height/2, width, l);
    }
    if (count > 2) {
        XYNewItemView * view = [_subNewsView objectAtIndex:2];
        view.frame = CGRectMake(width+80, 0, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineVArray objectAtIndex:1];//|
        line.frame = CGRectMake(width*2+80+gap_s2, 0, l, height);
    }
    if (count > 3) {
        XYNewItemView * view = [_subNewsView objectAtIndex:3];
        view.frame = CGRectMake(width+80, gap, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(width+80, gap-gap_s2, width, l);
    }
    if (count > 4) {
        XYNewItemView * view = [_subNewsView objectAtIndex:4];
        view.frame = CGRectMake(width+80, gap*2, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(width+80, gap*2-gap_s2, width, l);
    }
    if (count > 5) {
        XYNewItemView * view = [_subNewsView objectAtIndex:5];
        view.frame = CGRectMake(2*(width+40)+40, 0, width, 173);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
    }
    if (count > 6) {
        XYNewItemView * view = [_subNewsView objectAtIndex:6];
        view.frame = CGRectMake(2*(width+40)+40, gap, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(2*(width+40)+40, gap-gap_s2, width, l);
    }
    if (count > 7) {
        XYNewItemView * view = [_subNewsView objectAtIndex:7];
        view.frame = CGRectMake(2*(width+40)+40, gap*2, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(2*(width+40)+40, gap*2-gap_s2, width, l);
    }
    
}
- (void)layout7ContextContextCount:(NSInteger)count{
    [self normalLineFrame];
    float height = NEWSCELL_HEIGHT;
    float h1 = 375;
    float h2 = 170;
    float hs = 80;
    float l = 1;
    float th = 75;
    float gap = (height-h2*3)/2+h2;
    float gap_s2 = (height-h2*3)/4;
    float width = 260;
    float iw = 230;
    float ih = 160;
    int x=0;
    if (count > 0) {
        XYNewItemView * view = [_subNewsView objectAtIndex:0];
        view.frame = CGRectMake(40, 0, width, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);//
        view.imageView.frame = CGRectMake((width-iw)/2-5, th+25, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2.0);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, width, hs);
        
        UIView * line = [_lineVArray objectAtIndex:0];//|
        line.frame = CGRectMake(width+40+gap_s2, 0, l, height);
    }
    if (count > 1) {
        XYNewItemView * view = [_subNewsView objectAtIndex:1];
        view.frame = CGRectMake(40, height-h2, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(40, height-h2-gap_s2, width, l);
    }
    if (count > 2) {
        XYNewItemView * view = [_subNewsView objectAtIndex:2];
        view.frame = CGRectMake(width+80, 0, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineVArray objectAtIndex:1];//|
        line.frame = CGRectMake(width+80+width+gap_s2, 0, l, height);
    }
    if (count > 3) {
        XYNewItemView * view = [_subNewsView objectAtIndex:3];
        view.frame = CGRectMake(width+80, gap, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(width+80, gap-gap_s2, width, l);
    }
    if (count > 4) {
        XYNewItemView * view = [_subNewsView objectAtIndex:4];
        view.frame = CGRectMake(width+80, gap*2, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(width+80, gap*2-gap_s2, width, l);
    }
    if (count > 5) {
        XYNewItemView * view = [_subNewsView objectAtIndex:5];
        view.frame = CGRectMake(2*(width+40)+40, 0, width, h2);
        view.imageView.hidden = YES;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.subTitleLabel.frame = CGRectMake(0, h2-hs, width, hs);
    }
    if (count > 6) {
        XYNewItemView * view = [_subNewsView objectAtIndex:6];
        view.frame = CGRectMake(2*(width+40)+40, gap, width, h1);
        view.imageView.hidden = NO;
        view.titleLabel.frame = CGRectMake(0, 0, width, th);
        view.imageView.frame = CGRectMake((width-iw)/2-5, th+30, iw, ih);
        view.normal_bg1.frame = view.imageView.frame;
        view.normal_bg2.center = CGPointMake(iw/2, ih/2.0);
        view.subTitleLabel.frame = CGRectMake(0, h1-hs, width, hs);
        
        UIView * line = [_lineHArray objectAtIndex:x++];//-
        line.frame = CGRectMake(2*(width+40)+40, gap-gap_s2, width, l);
    }
}
@end
