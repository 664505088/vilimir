//
//  XYViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-21.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYViewController.h"
#import "XYLoginViewController.h"
@interface XYViewController ()

@end




@implementation XYViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sqlManager = [XYSqlManager defaultService];
    self.editManager = [XYEditManager shardManager];
    
    
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    self.xNavigationBar = [[XYNavigationBar alloc] initWithFrame:CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT)];
    [self.view addSubview:_xNavigationBar];
    
    UIButton * editBtn = [_xNavigationBar.items objectAtIndex:0];
    UIButton * loginBtn = [_xNavigationBar.items objectAtIndex:1];
    editBtn.tag = 0;
    loginBtn.tag = 1;
    [editBtn addTarget:self action:@selector(clickNavigationItemWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn addTarget:self action:@selector(clickNavigationItemWithButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建主视图
    self.xView = [XYFactory createViewWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-TOOLBAR_HEIGHT) color:nil];
//    _xView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_xView];

    ///创建工具栏按钮
    self.xToolBar = [[XYToolBar alloc] initWithFrame:CGRectMake(0, H_HEIGHT-TOOLBAR_HEIGHT, H_WIDTH, TOOLBAR_HEIGHT)];
    [self.view addSubview:_xToolBar];
    
//    self.xNavigationBar.backgroundColor = [UIColor greenColor];
//    self.xView.backgroundColor = [UIColor blueColor];
//    self.xToolBar.backgroundColor = [UIColor greenColor];
}



- (BOOL)netStatus {
//    return NO;
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable;

}




- (UIImage *)screenshotMH{
    CGSize size = self.tabBarController.view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    if ([self.tabBarController respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self.tabBarController.view drawViewHierarchyInRect:self.tabBarController.view.bounds afterScreenUpdates:YES];
    } else {
        [self.tabBarController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 点击

//点击导航按钮
- (void)clickNavigationItemWithButton:(UIButton*)btn {
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    XYLoginViewController * vc = [[XYLoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    if (btn.tag == 0) {
        vc.isSelectedEdit = YES;
    }
    [self presentViewController:nav animated:NO completion:nil];

}



#pragma mark - 动画
///刷新按钮添加动画
- (void)RefreshAddAnimation {
    CABasicAnimation  *rotationAnimation = [CABasicAnimation  animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber  numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    rotationAnimation.delegate = self;
    
    UIButton * button = [self.xNavigationBar.items lastObject];
    [button.layer  addAnimation:rotationAnimation forKey:@"animate"];
}
///刷新按钮移除动画
- (void)RefreshCloseAnimation {
    UIButton * button = [self.xNavigationBar.items lastObject];
    [button.layer removeAnimationForKey:@"animate"];
}
@end
