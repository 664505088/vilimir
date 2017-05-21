//
//  XYAdvertisementViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-29.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYAdvertisementViewController.h"

@interface XYAdvertisementViewController ()
<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation XYAdvertisementViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.xNavigationBar.hidden = YES;
//    self.xView.frame = CGRectMake(0, 0, H_WIDTH, H_HEIGHT-TOOLBAR_HEIGHT);

    for (int i=0; i<self.xToolBar.items.count; i++) {
        UIButton * btn = [self.xToolBar.items objectAtIndex:i];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"news_tool11"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"news_tool12"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            btn.hidden = YES;
        }
    }
    
    
    for (int i=0; i<self.xNavigationBar.items.count; i++) {
        UIButton * btn = [self.xNavigationBar.items objectAtIndex:i];
        if (i==2) {
            [btn addTarget:self action:@selector(loadWebView) forControlEvents:UIControlEventTouchUpInside];
        }else {
            btn.hidden = YES;
        }
    }
    //创建内容视图
    _webView = [[UIWebView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_webView];
    _webView.delegate = self;
    
    [self loadWebView];
}

//加载webView/动画
- (void)loadWebView {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)clickbackButton:(UIButton*)btn {
    if ([self.navigationController.viewControllers indexOfObject:self]==1) {
        self.tabBarController.hidesBottomBarWhenPushed = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self RefreshCloseAnimation];
    UIButton * button = [self.xNavigationBar.items objectAtIndex:2];
    [button.layer removeAnimationForKey:@"animate"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self RefreshCloseAnimation];
    [SVProgressHUD showErrorWithStatus:@"数据加载失败" duration:1];
}
@end
