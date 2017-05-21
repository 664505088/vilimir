//
//  XYHeadPageItemCell.h
//  SecuritiesDaily
//  新闻列表焦点cell
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UILabel+ShowStringLength.h"
@interface XYHeadPageItemCell : UITableViewCell
{
    UIView      * normal_bg1;
    UIImageView * normal_bg2;
}
@property (nonatomic, retain) UILabel * titleLabel;
@property (nonatomic, retain) UIImageView * headImageView;

@end
