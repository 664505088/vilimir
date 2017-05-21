//
//  XYForgetView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildView.h"

@interface XYForgetView : XYChildView
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * _dataArray;
}
@property (nonatomic, strong) UIButton * backBtn;//返回
@property (nonatomic, strong) UIButton * forgetBtn;//找回密码

@property (nonatomic, strong) UITextField * usernameTextField;//账号

@property (nonatomic, strong) UITableView   * tableView;

@end
