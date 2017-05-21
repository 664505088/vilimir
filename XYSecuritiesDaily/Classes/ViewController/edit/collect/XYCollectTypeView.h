//
//  XYCollectTypeView.h
//  SecuritiesDaily
//  选项卡(文章/图片)
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LABEL_TAG 40

@interface XYCollectTypeView : UIView
{
    id _target;
    SEL _action;
}


@property (nonatomic, strong)NSMutableArray * buttons;
@property (nonatomic, strong)UIImageView * redView;
@property (nonatomic) NSInteger  selectedIndex;

//间隔
@property (nonatomic) float  gap;

- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles;
- (void)addTarget:(id)target action:(SEL)action;
@end
