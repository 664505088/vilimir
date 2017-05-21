//
//  XYNewsCollectCell.h
//  SecuritiesDaily
//  新闻收藏cell
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCollect.h"
@interface XYNewsCollectCell : UITableViewCell
{
    UIImageView * _lineView;
}
@property (nonatomic, strong)UIView  * bgView;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * subTitleLabel;

@property (nonatomic)BOOL   leftMove;

- (void)setCollect:(MDCollect*)collect;



@end
