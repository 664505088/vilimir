//
//  XYChildViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"

@interface XYChildViewController ()
{
    UIImageView * _backgroundImageView;
    
}
@end

@implementation XYChildViewController

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//  
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.editManager = [XYEditManager shardManager];
    self.sqlManager = [XYSqlManager defaultService];
    
    //蒙黑背景
    UIView * view = [XYFactory createViewWithFrame:CGRectMake(0, 0, H_WIDTH, H_HEIGHT) color:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlackPoint)];
    [view addGestureRecognizer:gr];
    
    
    
    //布局背景
    self.xView = [XYFactory createViewWithFrame:CGRectMake(330, 0, 751/2.0, WIN_SIZE.width) color:nil];
    [self.view addSubview:_xView];
    [self.view bringSubviewToFront:_xView];
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    if (self.xView != nil) {
        [self scaleAnimation];
    }
}

//点击黑色空白区域
- (void)clickBlackPoint {
    if (_isShowKeyBorder) {//有键盘时
        [self.view endEditing:YES];
    }else {//否则返回
        [UIView animateWithDuration:0.3f animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            self.view.alpha = 1;
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}


- (void)scaleAnimation {
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //    pulse.duration = 0.1 + (rand() % 10) * 0.01;
    pulse.duration = 0.1;
    pulse.repeatCount = 2;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:1.01];
    pulse.toValue = [NSNumber numberWithFloat:.99];
    [self.xView.layer addAnimation:pulse forKey:@"transform.scale"];
}


//隐藏/显示键盘调用
- (void)keyboardHide:(NSNotification*)notification {
    self.isShowKeyBorder = NO;
}
- (void)keyboardShow:(NSNotification*)notification {
    self.isShowKeyBorder = YES;
}
@end
