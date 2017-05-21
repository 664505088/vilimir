//
//  XYPageIndexControl.h
//  SecuritiesDaily
//  显示页码(0/5)
//  Created by xiwang on 14-5-26.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPageIndexControl : UIView

@property (nonatomic, retain)UILabel * indexLabel;
@property (nonatomic, retain)UILabel * countLabel;

@property (nonatomic) int index;
@property (nonatomic) int count;

- (void)setindex:(int)index Count:(int)count;

@end
