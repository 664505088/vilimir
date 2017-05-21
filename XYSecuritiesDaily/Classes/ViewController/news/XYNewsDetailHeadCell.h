//
//  XYNewsDetailHeadCell.h
//  XYSecuritiesDaily
//  由于更改为web显示,暂时无用
//  Created by xiwang on 14-7-9.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewsDetailCell.h"

//字体
#define NEWSDETAIL_TITLE_FONT [UIFont fontWithName:@"TrebuchetMS-Bold" size:30]
#define NEWSDETAIL_SUBTITLE_FONT 15

@interface XYNewsDetailHeadCell : XYNewsDetailCell


@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * create_timeLabel;

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIView    * grayView;

@property (nonatomic) float h1;
@property (nonatomic) float h2;
@property (nonatomic) float h3;

@property (nonatomic, strong) MDNewsDetail * newsDetail;



@end
