//
//  XYMessageCell.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMessage.h"
@interface XYMessageCell : UITableViewCell
{
    UIImageView *_lineView;
}
@property (nonatomic, strong) UIView    * bgView;
@property (nonatomic, strong) UILabel   * descriptLabel;
@property (nonatomic, strong) UILabel   * dateLabel;
@property (nonatomic)BOOL   leftMove;
- (void)setMessage:(MDMessage*)message;

@end
