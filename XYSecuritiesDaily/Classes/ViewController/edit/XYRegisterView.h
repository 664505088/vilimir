//
//  XYRegisterView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"

@interface XYRegisterView : XYChildView
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * _dataArray;
}

@property (nonatomic, strong) UIButton * backBtn;//返回
@property (nonatomic, strong) UIButton * registerBtn;//确认注册

@property (nonatomic, strong) UITextField * usernameTextField;//账号
@property (nonatomic, strong) UITextField * passwordTextField1;//密码
@property (nonatomic, strong) UITextField * passwordTextField2;//密码

@property (nonatomic, strong) UITableView   * tableView;
@end
