//
//  XYEpaperDetailViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperDetailViewController.h"


@implementation XYEpaperDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, H_WIDTH, H_HEIGHT)];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.epaper.pdf]];
    [_webView loadRequest:request];
    [SVProgressHUD showWithStatus:@"文件较大,请耐心等待下载"];
    
    UIButton * btn = [XYFactory createButtonWithFrame:CGRectMake(40, H_HEIGHT-50, 30, 30) Image:@"news_tool11" Image:@"news_tool12"];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(goBackViewController) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击
- (void)goBackViewController {
    [_webView stopLoading];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView addTouchesJavaScript];
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"数据加载失败" duration:1];
    [webView addTouchesJavaScript];
}

- (BOOL)webView:(UIWebView*)aWebView
shouldStartLoadWithRequest:(NSURLRequest*)aRequest
 navigationType:(UIWebViewNavigationType)aNavigationType {
    
    NSString *requestString = [[aRequest URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 2
		&& [(NSString *)[components objectAtIndex:0] isEqualToString:@"thweb"]
		&& [(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
	{
        NSString *eventString=[components objectAtIndex:2];
        if ([eventString isEqualToString:@"start"]) {
            //开始点击
        }
		if ([eventString isEqualToString:@"end"]) {
            //点击结束

		}
        return NO;
    }
    return YES;
}



@end
