//
//  XYViewController.h
//  SecuritiesDaily
//  用作父类(包含导航栏/工具栏/主视图/ 管理(sql,edit,网络判断))
//  Created by xiwang on 14-5-21.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNavigationBar.h"
#import "XYToolBar.h"
#import "GDataXMLNode.h"

#import "NSString+MD5.h"

#define AD_HEIGHT 48




@interface XYViewController : UIViewController



@property (nonatomic, strong)XYNavigationBar * xNavigationBar;
@property (nonatomic, strong)UIView         * xView;
@property (nonatomic, strong)XYToolBar      * xToolBar;

@property (nonatomic, strong) XYSqlManager      * sqlManager;
@property (nonatomic, strong) XYEditManager     * editManager;

@property (nonatomic, readonly)   BOOL    netStatus;
/////截屏
//- (UIImage *)screenshotMH;
///刷新按钮添加动画
- (void)RefreshAddAnimation;
///刷新按钮移除动画
- (void)RefreshCloseAnimation;
@end
