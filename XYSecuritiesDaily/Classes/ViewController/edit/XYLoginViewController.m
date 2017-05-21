//
//  XYLoginViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYLoginViewController.h"


@implementation XYLoginViewController

- (void)createLoginView {
    //登录界面
    _loginView = [[XYLoginView alloc] initWithFrame:self.xView.bounds];
    _loginView.forgetBtn.tag = 0;
    _loginView.registerBtn.tag = 1;
    _loginView.loginBtn.tag = 2;
    [_loginView.loginBtn addTarget:self action:@selector(clickLoginPageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerBtn addTarget:self action:@selector(clickLoginPageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.forgetBtn addTarget:self action:@selector(clickLoginPageBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)createRegisterView {
    //注册界面
    _registerView = [[XYRegisterView alloc] initWithFrame:self.xView.bounds];
    _registerView.backBtn.tag = 0;
    _registerView.registerBtn.tag = 1;
    [_registerView.backBtn addTarget:self action:@selector(clickRegisterPageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.registerBtn addTarget:self action:@selector(clickRegisterPageBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)createForgetView {
    //找回密码界面
    _forgetView = [[XYForgetView alloc] initWithFrame:self.xView.bounds];
    _forgetView.backBtn.tag = 0;
    _forgetView.forgetBtn.tag = 1;
    [_forgetView.backBtn addTarget:self action:@selector(clickForgetPageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetView.forgetBtn addTarget:self action:@selector(clickForgetPageBtn:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)createUserInfoView {
    //用户界面
    _infoView = [[XYUserInfoView alloc] initWithFrame:self.xView.bounds];
    [_infoView.rightButton addTarget:self action:@selector(clickInfoPageEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickInfoPageHeadImage:)];
    [_infoView.imageView addGestureRecognizer:gr];
    for (int i =0; i<_infoView.toolButtons.count; i++) {
        UIButton * button = [_infoView.toolButtons objectAtIndex:i];
        button.tag = i;
        [button addTarget:self action:@selector(clickToolViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)createInfoEditView {
    //用户编辑界面
    _editInfoView = [[XYEditInfoView alloc] initWithFrame:self.xView.bounds];
    [_editInfoView.rightButton addTarget:self action:@selector(clickeditInfoPageEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _editInfoView.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEditInfoPageImageView:)];
    [_editInfoView.imageView addGestureRecognizer:gr];
    
    for (int i =0; i<_editInfoView.toolButtons.count; i++) {
        UIButton * button = [_editInfoView.toolButtons objectAtIndex:i];
        button.tag = i;
        [button addTarget:self action:@selector(clickToolViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)createEditView {
    _editView = [[XYEditView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_editView];
    for (int i=0; i<_editView.buttonArray.count; i++) {
        UIButton * btn = [_editView.buttonArray objectAtIndex:i];
        [btn addTarget:self action:@selector(clickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (int i=0; i<_editView.switchArray.count; i++) {
        UISwitch * sw = [_editView.switchArray objectAtIndex:i];
        [sw addTarget:self action:@selector(clickMenuSwitch:) forControlEvents:UIControlEventValueChanged];
    }

}

//刷新页面
- (void)reloadLoginPageData {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * username = [userDefaults objectForKey:@"username"];
    NSString * password = [userDefaults objectForKey:@"password"];
    if (username) {
        _loginView.usernameTextField.text = username;
    }
    if (password) {
        _loginView.passwordTextField.text = password;
    }
}
- (void)reloadInfoPageData {
    MDUser * user = [XYEditManager shardManager].user;
    [_infoView.imageView setImageWithURL:[NSURL URLWithString:user.image] placeholderImage:[UIImage imageNamed:@"info_touxiang"]];
    
    _infoView.nameLabel.text = user.nickName?user.nickName:@"昵称(空)";
    _infoView.phoneLabel.text = user.tel?user.tel:@"电话(空)";
    _infoView.mailLabel.text = user.username?user.username:@"邮箱(空)";
}
- (void)reloadEditInfoPageData {
    MDUser * user = [XYEditManager shardManager].user;
    
    [_editInfoView.imageView setImageWithURL:[NSURL URLWithString:user.image] placeholderImage:[UIImage imageNamed:@"info_touxiang"]];
    for (int i=0; i<_editInfoView.textFields.count; i++) {
        UITextField * textField = [_editInfoView.textFields objectAtIndex:i];
        switch (i) {
            case 0:textField.text = user.nickName?user.nickName:@"昵称(空)";break;
            case 1:textField.text = user.tel?user.tel:@"电话空";break;
            case 2:textField.text = user.username?user.username:@"邮箱(空)";break;
            case 3:textField.text = user.password?user.password:@"";break;
            case 4:textField.text = user.password?user.password:@"";break;
        }
    }
}
- (void)reloadEditPageData {
    self.editManager.sinaWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo];
    self.editManager.tencentWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeTencentWeibo];
    self.editManager.netEaseWeibo = [ShareSDK hasAuthorizedWithType:ShareType163Weibo];
    
    for (int i=0; i<_editView.switchArray.count; i++) {
        UISwitch * sw = [_editView.switchArray objectAtIndex:i];
        switch (i) {
            case 0:sw.on = self.editManager.sinaWeibo;break;
            case 1:sw.on = self.editManager.tencentWeibo;break;
            case 2:sw.on = self.editManager.netEaseWeibo;break;
            case 3:sw.on = self.editManager.screen;break;
            case 4:sw.on = self.editManager.page;break;
        }
    }
    for (int i=0; i<_editView.labelArray.count; i++) {
        UILabel * label = [_editView.labelArray objectAtIndex:i];
        switch (i) {
            case 0:{
                
                if (self.editManager.fontSize == XYEditFontBigSize) {
                    label.text = @"大 >";
                }else if (self.editManager.fontSize == XYEditFontMiddleSize) {
                    label.text = @"中 >";
                }else if (self.editManager.fontSize == XYEditFontSmallSize) {
                    label.text = @"小 >";
                }
            }break;
            case 1:label.text = [NSString stringWithFormat:@"V %@ >",self.editManager.version];break;
            case 2:{
                if (self.editManager.user.isLogin) {
                    label.text = @"退出登录";
                }else {
                    label.text = @"登录";
                }
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isSelectedEdit) {
        self.xView.frame = CGRectMake((H_WIDTH-375)/2, (H_HEIGHT-680)/2, 375, 680);
        [self createEditView];
        [self reloadEditPageData];
    }else {
        self.xView.frame = CGRectMake((H_WIDTH-340)/2, (H_HEIGHT-486)/2, 340, 486);
        if (self.editManager.user.isLogin) {
            [self createUserInfoView];
            [self reloadInfoPageData];
            [self.xView addSubview:_infoView];
        }else {
            [self createLoginView];
            [self reloadLoginPageData];
            [self.xView addSubview:_loginView];
            
        }
    }
}





#pragma mark - 点击
#pragma mark -
















#pragma mark - 设置页面点击事件
//点击按钮
- (void)clickMenuButton:(UIButton*) btn {
    if (btn.tag == 0) {//字体大小
        NSLog(@"字体大小");
        [[[UIAlertView alloc] initWithTitle:@"选择字体" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"大",@"中",@"小", nil] show];
        
    }else if (btn.tag == 1) {//检查更新
        [SVProgressHUD showWithStatus:@"正在检测最新版本"];
        NSString * url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@&country=cn",APP_ID];
        [[RequestService defaultService] getJsonRequestUrl:url parameters:nil success:^(id obj) {
            NSArray * infoArray = [obj objectForKey:@"results"];
            if (infoArray.count == 0) {
                [SVProgressHUD dismissWithError:@"不存在历史版本"];
            }else {
                //网络版本
                NSDictionary * infoDictionary = [infoArray objectAtIndex:0];
                NSString * v1String = [infoDictionary objectForKey:@"version"];
                NSString * v2String = self.editManager.version;
                NSArray * arr1 = [v1String componentsSeparatedByString:@"."];
                NSArray * arr2 = [v2String componentsSeparatedByString:@"."];
            
                
                NSInteger count = arr1.count<arr2.count?arr1.count:arr2.count;
                for (int i=0; i<count; i++) {
                    float v1 = [[arr1 objectAtIndex:i] floatValue];
                    float v2 = [[arr2 objectAtIndex:i] floatValue];
                    if (v2 < v1) {
                        [SVProgressHUD dismiss];
                        NSString * title = [NSString stringWithFormat:@"发现新版本%@，是否更新？",v1String];
                        NSString * message = [infoDictionary objectForKey:@"releaseNotes"];
                        _editView.trackViewUrl = [infoDictionary objectForKey:@"trackViewUrl"]; //更新URL
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"去更新", nil];
                        alertView.tag = 1;
                        [alertView show];
                        return ;
                    }
                    else if (v2 == v1) {
                        if (i==count-1) {
                            [SVProgressHUD dismissWithSuccess:@"当前为最新版本"];
                        }
                        continue;
                    }else {
                        [SVProgressHUD dismissWithError:@"当前为内测版本"];
                        return;
                    }
                }
            }      
        } falid:^(NSString *errorMsg) {
            [SVProgressHUD dismissWithError:errorMsg];
        }];
    }
    else if (btn.tag == 2) {//登录登出
        UILabel * label = [_editView.labelArray objectAtIndex:2];
        if ([XYEditManager shardManager].user.isLogin) {//(已登录)点击退出登录
            [XYEditManager shardManager].user.isLogin = NO;
            [XYEditManager shardManager].user.password = nil;
            label.text = @"登录";
        }else {
            [UIView animateWithDuration:0.5 animations:^{
                self.xView.frame = CGRectMake((H_WIDTH-340)/2, (H_HEIGHT-486)/2, 340, 486);
                if (_loginView == nil) {
                    [self createLoginView];
                }
                [self reloadLoginPageData];
                [_editView pushView:_loginView];
            }];
      
        }
    }
}
- (void)clickMenuSwitch:(UISwitch*)sender {
//    ShareTypeSinaWeibo = 1,         /**< 新浪微博 */
//	ShareTypeTencentWeibo = 2,      /**< 腾讯微博 */
//	ShareTypeSohuWeibo = 3,         /**< 搜狐微博 */
//    ShareType163Weibo = 4,          /**< 网易微博 */
    NSInteger index = [_editView.switchArray indexOfObject:sender];
    ShareType type = ShareTypeSinaWeibo;
    if (index < 3) {  //微博授权
        switch (index) {
            case 0:type = ShareTypeSinaWeibo;break;
            case 1:type = ShareTypeTencentWeibo;break;
            case 2:type = ShareType163Weibo;break;
        }
        if (sender.on)
        {
            //用户用户信息
            id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                 allowCallback:YES
                                                                 authViewStyle:SSAuthViewStyleFullScreenPopup
                                                                  viewDelegate:nil
                                                       authManagerViewDelegate:nil];
            
            //在授权页面中添加关注官方微博
            [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                            nil]];
            
            [ShareSDK getUserInfoWithType:type
                              authOptions:authOptions
                                   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                       if (result)
                                       {
//                                           [item setObject:[userInfo nickname] forKey:@"username"];
//                                           [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
                                       }
                                       NSLog(@"%d:%@",(int)[error errorCode], [error errorDescription]);
                                       [self reloadEditPageData];
                                   }];
        }
        else
        {
            //取消授权
            [ShareSDK cancelAuthWithType:type];
            [self reloadEditPageData];
        }

    }
    else {
        if (index == 3) {//全屏
            self.editManager.screen = sender.on;
        }
        else if (index == 4) {//翻页
            [SVProgressHUD showErrorWithStatus:@"暂未开放此功能" duration:1.5f];
            sender.on = NO;
            return;
            self.editManager.page = sender.on;
        }
    }
 
 }



#pragma mark - 登录界面点击事件
///点击登录调用
- (void)clickLoginPageBtn:(UIButton*)btn {
    
    if (btn.tag == 0) {//忘记密码
        if (_forgetView==nil) {
            [self createForgetView];
        }
        [_loginView pushView:_forgetView];
    }
    
    
    else if (btn.tag == 1) { //注册
        if (_registerView == nil) {
            [self createRegisterView];
        }
        [_loginView pushView:_registerView];
    }
    
    
    if (btn.tag == 2) { //登录

        if (!_loginView.usernameTextField.text.isEmail || _loginView.usernameTextField.text.length < 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱地址" duration:1.5f];
        }
        else if (_loginView.usernameTextField.text.length > 35) {
            [SVProgressHUD showErrorWithStatus:@"账号长度应小于35个字符" duration:1.5f];
        }
        else if (_loginView.passwordTextField.text.length < 6 || _loginView.passwordTextField.text.length > 12) {
            [SVProgressHUD showErrorWithStatus:@"请输入6-12位字母或数字" duration:1.5f];
        }
        else {
            [self.view endEditing:YES];
            [self getLogin];
        }
    }
}




#pragma mark - 找回密码界面事件
- (void)clickForgetPageBtn:(UIButton*)btn {
    if (btn.tag == 0) {//返回
        [_forgetView pushView:_loginView];
    }
    
    else if (btn.tag == 1) {//找回密码
        if (!_forgetView.usernameTextField.text.isEmail) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱地址" duration:1.5f];
        }
        else {
            [self.view endEditing:YES];
            [self getForget];
        }
    }
}



#pragma mark - 注册界面点击事件
- (void)clickRegisterPageBtn:(UIButton*)btn {
    if (btn.tag == 0) {//返回到登陆
        [_registerView pushView:_loginView];
    }
    
    else if (btn.tag == 1) {//确认注册
        if (!_registerView.usernameTextField.text.isEmail || _registerView.usernameTextField.text.length < 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱地址" duration:1.5f];
        }
        else if (_registerView.passwordTextField1.text.length < 6 || _registerView.passwordTextField1.text.length > 12) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入6-12位字母或数字" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }
        else if (![_registerView.passwordTextField2.text isEqualToString:_registerView.passwordTextField1.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的密码不一致" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }
        else {
            [self.view endEditing:YES];
            [self getRegister];
        }
    }
}
//
//
//
//




#pragma mark - 详情界面点击事件
///点击编辑按钮
- (void)clickInfoPageEditBtn:(UIButton*)btn {
    if (_editInfoView == nil) {
        [self createInfoEditView];
    }
    [self reloadEditInfoPageData];
    [_infoView pushView:_editInfoView];
}
///点击头像
- (void)clickInfoPageHeadImage:(UITapGestureRecognizer*)gr {
    
}


///点击/我的跟帖/我的收藏.我的消息
- (void)clickToolViewWithButton:(UIButton*)btn {
    
    UIViewController * vc;
    if (btn.tag == 0) {//跟帖
        vc = [[XYCommentViewController alloc] init];
    }else if (btn.tag == 1) {//收藏
        vc = [[XYCollectViewController alloc] init];
    }else if (btn.tag == 2) {//消息
        vc = [[XYMessageViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 编辑界面点击事件
///点击头像
- (void)clickEditInfoPageImageView:(UITapGestureRecognizer *)gr {
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [sheet showInView:self.xView];
}

///点击保存
- (void)clickeditInfoPageEditBtn:(UIButton*)btn {
    UITextField * nick = [_editInfoView.textFields objectAtIndex:0];
    UITextField * phone = [_editInfoView.textFields objectAtIndex:1];
    UITextField * password1 = [_editInfoView.textFields objectAtIndex:3];
    UITextField * password2 = [_editInfoView.textFields objectAtIndex:4];
    
    if (nick.text.length ==0 || nick.text.length > 35) {
        [SVProgressHUD showErrorWithStatus:@"昵称长度应小于35" duration:1.5f];
    }else if (phone.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号" duration:1.5f];
    }else if (password1.text.length < 6 || password1.text.length > 12) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-12位字母或数字" duration:1.5f];
    }else if (![password2.text isEqualToString:password1.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致" duration:1.5f];
    }else {
        [self getUpdateUserInfo];
    }
    
}




#pragma mark - 解析
///登录
- (void)getLogin {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"2.2",@"mode",
                                 _loginView.usernameTextField.text,@"mail",
                                 [_loginView.passwordTextField.text MD5],@"password",nil];
    [SVProgressHUD showWithStatus:@"正在登录,请稍等"];
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {//登录成功
            
            MDUser * user = [XYEditManager shardManager].user;
            user.isLogin = YES;
            user.username = _loginView.usernameTextField.text;
            user.password = _loginView.passwordTextField.text;
            
            user.image = [[[root elementsForName:@"image"] firstObject] stringValue];
            user.tel = [[[root elementsForName:@"tel"] firstObject] stringValue];
            user.mail = [[[root elementsForName:@"mail"] firstObject] stringValue];
            user.userId = [[[root elementsForName:@"userId"] firstObject] stringValue];
            user.nickName = [[[root elementsForName:@"nickName"] firstObject] stringValue];
            [SVProgressHUD dismissWithSuccess:@"登录成功"];
            [UIView animateWithDuration:0.3f animations:^{
                self.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.view.alpha = 1;
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        }
        else {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD dismissWithError:msg];
        }
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD dismissWithError:errorMsg];
    }];
}

///找回密码
- (void)getForget {
    [SVProgressHUD showWithStatus:@"正在发送邮件..."];
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"2.3",@"mode",
                                 _forgetView.usernameTextField.text,@"mail",nil];

    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {
            [SVProgressHUD dismissWithSuccess:@"邮件发送成功"];
            [_forgetView pushView:_loginView];
            _loginView.usernameTextField.text = _forgetView.usernameTextField.text;
            _loginView.passwordTextField.text = @"";
        }
        else {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD dismissWithError:msg];
        }
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD dismissWithError:errorMsg];
    }];
}

///注册
- (void)getRegister {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"2.1",@"mode",
                                 _registerView.usernameTextField.text,@"mail",
                                 [_registerView.passwordTextField1.text MD5],@"password",nil];
    [SVProgressHUD showWithStatus:@"正在注册,请稍等..."];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD dismissWithSuccess:msg];
            MDUser * user = [XYEditManager shardManager].user;
            user.isLogin = YES;
            user.username = _registerView.usernameTextField.text;
            user.password = _registerView.passwordTextField1.text;
            NSString * idString = [[[root elementsForName:@"userId"] firstObject] stringValue];
            if (idString) user.userId = idString;
            [UIView animateWithDuration:0.3f animations:^{
                self.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.view.alpha = 1;
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        }
        else {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD dismissWithError:msg];
        }
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD dismissWithError:errorMsg];
    }];
}




///修改用户信息
- (void)getUpdateUserInfo {

    UITextField * nickname = [_editInfoView.textFields objectAtIndex:0];
    UITextField * tel = [_editInfoView.textFields objectAtIndex:1];
    UITextField * mail = [_editInfoView.textFields objectAtIndex:2];
    UITextField * password = [_editInfoView.textFields objectAtIndex:3];
    
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"2.5",@"mode",
                                 mail.text,@"mail",
                                 tel.text,@"tel",
                                 nickname.text,@"nickname",
                                 [password.text MD5],@"password",nil];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD showSuccessWithStatus:msg duration:1.5];
            
            MDUser * user = self.editManager.user;
            user.nickName = nickname.text;
            user.tel = tel.text;
            user.password = password.text;
            
            [self reloadInfoPageData];
            [_editInfoView pushView:_infoView];
        }else {
            NSString * msg = [[[root elementsForName:@"msg"] firstObject] stringValue];
            [SVProgressHUD showErrorWithStatus:msg duration:1.5];
        }
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg duration:1.5];
    }];
}









#pragma mark - 其他



///隐藏/显示键盘调用
- (void)keyboardHide:(NSNotification*)notification {
    self.isShowKeyBorder = NO;
    _editInfoView.scrollView.scrollEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _editInfoView.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:nil];
}
- (void)keyboardShow:(NSNotification*)notification {
    self.isShowKeyBorder = YES;
    _editInfoView.scrollView.scrollEnabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _editInfoView.scrollView.contentOffset = CGPointMake(0, 140);
    } completion:nil];
}



#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        XYSystemAlbumViewController * vc = [[XYSystemAlbumViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.delegate = self;
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
       
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            [SVProgressHUD showErrorWithStatus:@"不能使用相机" duration:1.5f];
        }
        
    }
 
}

#pragma mark - alertViewDelgate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //设置字体
    if (alertView.tag == 0) {
        UILabel * fontLabel = [_editView.labelArray objectAtIndex:0];
        if (buttonIndex==1) {
            [XYEditManager shardManager].fontSize = XYEditFontBigSize;
            fontLabel.text = @"大 >";
        }else if (buttonIndex == 2) {
            [XYEditManager shardManager].fontSize = XYEditFontMiddleSize;
            fontLabel.text = @"中 >";
        }else if (buttonIndex == 3) {
            [XYEditManager shardManager].fontSize = XYEditFontSmallSize;
            fontLabel.text = @"小 >";
        }
    }
    //更新
    else if (alertView.tag == 1) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_editView.trackViewUrl]];
        }
    }
    //设置头像
    else if (alertView.tag == 2) {
        if (buttonIndex==1) {
            UIImage * image = _editInfoView.imageView.image;
            NSData * imageData = UIImagePNGRepresentation(image);
            if (!imageData) {
                imageData = UIImageJPEGRepresentation(image, 1.0);
            }
            NSDictionary * parameters = @{@"mode":@"pad_2.5",@"mail":self.editManager.user.username};
     
            [[RequestService defaultService] getJsonRequestUrl:HOST_UPLOADING parameters:parameters imageData:imageData success:^(NSString * stringData) {
                //取到根节点
                GDataXMLDocument * document= [[GDataXMLDocument alloc] initWithXMLString:stringData options:0 error:nil];
                GDataXMLElement * rootElement = [document rootElement];
                
                NSString * result = [[[rootElement elementsForName:@"result"] firstObject] stringValue];
                NSString * msg = [[[rootElement elementsForName:@"msg"] firstObject] stringValue];
                
                if ([result isEqualToString:@"yes"]) {
                    [SVProgressHUD showSuccessWithStatus:msg duration:1.5f];
                    NSString * image = [[[rootElement elementsForName:@"image"] firstObject] stringValue];;
                    self.editManager.user.image = image;
                }else {
                    [SVProgressHUD showErrorWithStatus:msg duration:1.5f];
                }
            } falid:^(NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg duration:1.5f];
            }];
        }
        else {
            [_editInfoView.imageView setImageWithURL:[NSURL URLWithString:self.editManager.user.image] placeholderImage:[UIImage imageNamed:@"info_touxiang"]];
        }
    }
}



#pragma mark - 相册代理
//点击取消调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//获取到图片调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = (UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"];

    NSData * data = UIImageJPEGRepresentation(img, 0.3);
    UIImage * imageSmall = [UIImage imageWithData:data];
    _editInfoView.imageView.image = imageSmall;
    
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传头像" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.tag = 2;
    [av show];
}



@end
