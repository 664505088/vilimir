//
//  XYLoginView.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//


#import "XYChildView.h"
#import "XYLoginViewDelegate.h"

#define kUsername_length 35
#define kPassword_length 12

@interface XYLoginView : XYChildView
<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
}

@property (nonatomic, strong) UIButton      * registerBtn;//注册
@property (nonatomic, strong) UIButton      * loginBtn;//登录
@property (nonatomic, strong) UIButton      * forgetBtn;//忘记密码

@property (nonatomic, strong) UITextField   * usernameTextField;//账号
@property (nonatomic, strong) UITextField   * passwordTextField;//密码

@property (nonatomic, strong) UITableView   * tableView;
@end
