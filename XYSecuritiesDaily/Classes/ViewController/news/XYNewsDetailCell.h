//
//  XYNewsDetailCell.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-9.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNewsDetailCell : UITableViewCell




//间距
#define NEWSDETAIL_GAP_H 50
#define NEWSDETAIL_GAP_V 40

#define NEWSDETAIL_WIDTH 440
#define NEWSDETAIL_HEIGHT 585
#define NEWSDETAIL_IMG_HEIGHT 250

//- (void)setNewsDetail:(MDNewsDetail*)newsDetail;
@property (nonatomic, strong)UILabel * leftLabel;
@property (nonatomic, strong)UILabel * rightLabel;

@property (nonatomic, strong)NSValue * value1;
@property (nonatomic, strong)NSValue * value2;


@end
