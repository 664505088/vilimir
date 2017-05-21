//
//  XYWelcomeViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYWelcomeViewController.h"
#import "AppDelegate.h"
#import "GDataXMLNode.h"
#import "XYTabBarController.h"



@implementation XYWelcomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //pres推出视图显示底层视图
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.navigationController.navigationBarHidden = YES;
    
    
    _loadingImageView = [XYFactory createImageViewWithFrame:CGRectMake(0, 0, H_WIDTH, H_HEIGHT) Image:@"welcome_page"];
    [self.view addSubview:_loadingImageView];
    _loadingImageView.userInteractionEnabled = NO;
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLoadingImageView:)];
    [_loadingImageView addGestureRecognizer:gr];
    
    
    //集成微博
    [self shareSDKRegisterApp];
    
    
    //判断是否有网络
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {//如果有网络时候
        //如果有网络判断是否更新
        //获取loading页面数据
        [self getLoadingDataSource];
    }else {
        [self getMainViewController];
    }
}



#pragma mark - 点击
- (void)clickLoadingImageView:(UITapGestureRecognizer*)gr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_loadingUrl]];
}



//注册第三方分享功能
- (void)shareSDKRegisterApp {
    //    shareSDK注册
    [ShareSDK registerApp:ShareSDK_RegisterApp];
//    [ShareSDK convertUrlEnabled:YES];
    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
    [ShareSDK importWeChatClass:[WXApi class]];
    //    新浪微博
    [ShareSDK connectSinaWeiboWithAppKey:Sina_AppKey
                               appSecret:Sina_AppSecret
                             redirectUri:Sina_RedirectUri];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:Tencent_AppKey
                                  appSecret:Tencent_AppSecret
                                redirectUri:Tencent_RedirectUri
                                   wbApiCls:[WeiboApi class]];
    
    /**
     *	@brief	连接网易微博应用以使用相关功能，此应用需要引用T163WeiboConnection.framework
     *          http://open.t.163.com上注册网易微博开放平台应用，并将相关信息填写到以下字段
     *
     *	@param 	appKey 	应用Key
     *	@param 	appSecret 	应用密钥
     *	@param 	redirectUri 	回调地址
     */
    [ShareSDK connect163WeiboWithAppKey:Nets_AppKey
                              appSecret:Nets_AppSecret
                            redirectUri:Nets_RedirectUri];
    
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:Tencent_WeChatAppId wechatCls:[WXApi class]];
}



#pragma mark - 解析
///获取loading页面数据
- (void)getLoadingDataSource {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.8",@"mode",nil];

    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {
            NSString * url = [[[root elementsForName:@"url"] firstObject] stringValue];
            NSString * image = [[[root elementsForName:@"image"] firstObject] stringValue];
            
            [_loadingImageView setImageWithURL:[NSURL URLWithString:image]];
            _loadingImageView.frame = CGRectMake(0, 0, H_WIDTH, H_HEIGHT);
            _loadingUrl = url;
            _loadingImageView.userInteractionEnabled = YES;
            [self performSelector:@selector(getVersionUpdate) withObject:nil afterDelay:LoadingDuration];
        }else {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            NSLog(@"%@",msg);
//            [SVProgressHUD showErrorWithStatus:msg duration:1.5f];
            [self getVersionUpdate];
        }
    } falid:^(NSString *errorMsg) {
        NSLog(@"loading加载失败 %@",errorMsg);
        [self getVersionUpdate];
    }];
}

///获取最新版本
- (void)getVersionUpdate {
    NSString * url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@&country=cn",APP_ID];
    [[RequestService defaultService] getJsonRequestUrl:url parameters:nil success:^(id obj) {
        NSArray * infoArray = [obj objectForKey:@"results"];
        if (infoArray.count > 0) {
            //网络版本
            NSDictionary * infoDictionary = [infoArray objectAtIndex:0];
            NSString * v1String = [infoDictionary objectForKey:@"version"];
            NSString * v2String = [XYEditManager shardManager].version;
            NSArray * arr1 = [v1String componentsSeparatedByString:@"."];
            NSArray * arr2 = [v2String componentsSeparatedByString:@"."];
            
            NSInteger count = arr1.count<arr2.count?arr1.count:arr2.count;
            for (int i=0; i<count; i++) {
                float v1 = [[arr1 objectAtIndex:i] floatValue];
                float v2 = [[arr2 objectAtIndex:i] floatValue];
                if (v2 < v1) {
                    NSString * title = [NSString stringWithFormat:@"发现新版本%@-该版本内容更全功能更强大，是否更新?",v1String];
                    NSString * message = [infoDictionary objectForKey:@"releaseNotes"];
                    _updateUrl = [infoDictionary objectForKey:@"trackViewUrl"]; //更新URL
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alertView.tag = 1;
                    [alertView show];
                    return ;
                }
            }
            [self automaticLogin];
        }
    } falid:^(NSString *errorMsg) {
        NSLog(@"获取版本失败");
        //获取菜单列表
        [self automaticLogin];
    }];

}

///自动登录
- (void)automaticLogin {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * username = [userDefaults objectForKey:@"username"];
    NSString * password = [userDefaults objectForKey:@"password"];
    if (username && password) { //判断是否自动登录
        NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"2.2",@"mode",
                                     username,@"mail",
                                     [password MD5],@"password",nil];
        [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
            NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
            if ([result isEqualToString:@"yes"]) {//登录成功
                
                MDUser * user = [XYEditManager shardManager].user;
                user.isLogin = YES;
                user.username = username;
                user.password = password;
                
                user.image = [[[root elementsForName:@"image"] firstObject] stringValue];
                user.tel = [[[root elementsForName:@"tel"] firstObject] stringValue];
                user.mail = [[[root elementsForName:@"mail"] firstObject] stringValue];
                user.userId = [[[root elementsForName:@"userId"] firstObject] stringValue];
                user.nickName = [[[root elementsForName:@"nickName"] firstObject] stringValue];
                
                if (user.userId == nil) {
                    user.userId = @"-1";
                }
            }
            else {//登录失败
                [SVProgressHUD showErrorWithStatus:@"自动登录失败" duration:1.5];
            }
            [self getMenuDataSource];
        } falid:^(NSString *errorMsg) {//连接服务器失败
            [SVProgressHUD showErrorWithStatus:@"自动登录失败" duration:1.5];
            [self getMenuDataSource];
        }];

    }
    else { //没有自动登录
        [self getMenuDataSource];
    }
}




///获取服务器菜单栏
- (void)getMenuDataSource {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.0",@"mode",
                                 @"2",@"company_id",nil];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * array = [[[root elementsForName:@"news_type_list"] firstObject] elementsForName:@"news_type"];
        
        if (array.count >0) {
            //删除数据库原本内容
            [[XYSqlManager defaultService] deleteFromTableName:TABLE_NewsType where:nil];
            //存入本地数据库
            for (int i=0; i<array.count; i++) {
                GDataXMLElement * element = [array objectAtIndex:i];
                MDNewsType *newsType = [[MDNewsType alloc] initWithElement:element];
                [[XYSqlManager defaultService] insertItem:newsType];
            }
        }
        [self getMainViewController];
    } falid:^(NSString *errorMsg) {
        NSLog(@"获取菜单列表失败");
        [self getMainViewController];
    }];
}


- (void)getMainViewController {
    int count = [[XYSqlManager defaultService] selectCountWithTableName:TABLE_NewsType where:nil];
    if (count == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取新闻类型失败,请检查网络后重启客户端" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else {
        CATransition * transition = [CATransition transactionWithDuration:1 type:CATransitionTypeRippleEffect];
        [self.navigationController.view.layer removeAllAnimations];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        XYTabBarController * tabBar = [[XYTabBarController alloc] init];
        [self.navigationController pushViewController:tabBar animated:NO];
    }
}



#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {//更新提示框
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
        }
    }
    [self automaticLogin];//去自动登录
}


@end
