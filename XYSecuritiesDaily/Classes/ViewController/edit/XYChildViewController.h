//
//  XYChildViewController.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYToolHeader.h"
#import "GDataXMLNode.h"

@interface XYChildViewController : UIViewController

@property (nonatomic, strong) XYEditManager     * editManager;
@property (nonatomic, strong) XYSqlManager      * sqlManager;

@property (nonatomic) BOOL                      isShowKeyBorder;

@property (nonatomic, strong)UIView             * xView;



///点击黑色区域
- (void)clickBlackPoint;

//抖动动画
- (void)scaleAnimation;
@end
