//
//  XYLoginView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYLoginView.h"

@implementation XYLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //登录视图背景
        UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.bounds Image:@"info_bg1"];
        [self addSubview:loginBg];
        
        //账号密码分割线
        UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(31, 131, 280, 1) Image:nil];
        line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self addSubview:line_H];
        
        //账号图标
        UIImageView * username_Icon = [XYFactory createImageViewWithFrame:CGRectMake(35, 83, 16.5, 20) Image:@"info_icon_zhanghao"];
        [self addSubview:username_Icon];
        
        //密码图标
        UIImageView * password_Icon = [XYFactory createImageViewWithFrame:CGRectMake(34, 158, 20, 20) Image:@"info_icon_mima"];
        [self addSubview:password_Icon];
        
        
        //忘记密码按钮
        self.forgetBtn = [XYFactory createButtonWithFrame:CGRectMake(240, 12, 89, 30) Image:@"info_button_forget1" Image:@"info_button_forget2"];
        _forgetBtn.clipsToBounds = NO;
        [self addSubview:_forgetBtn];
        
        [_forgetBtn addSubview:[XYFactory createLabelWithFrame:_forgetBtn.bounds Text:@"忘记密码" Color:COLOR_RGB(146,154,155) Font:17 textAlignment:1]];
        
        
        //注册
        self.registerBtn = [XYFactory createButtonWithFrame:CGRectMake(32, 205, 128, 42.5) Image:@"info_button_register1" Image:@"info_button_register2"];
        [self addSubview:_registerBtn];
        [_registerBtn addSubview:[XYFactory createLabelWithFrame:_registerBtn.bounds Text:@"注册" Color:nil Font:17 textAlignment:1]];
        
        //登录
        self.loginBtn = [XYFactory createButtonWithFrame:CGRectMake(180, 205, 128, 42.5) Image:@"info_button_login1" Image:@"info_button_login2"];
        [self addSubview:_loginBtn];
        _loginBtn.tag = 2;
        
        [_loginBtn addSubview:[XYFactory createLabelWithFrame:_loginBtn.bounds Text:@"登录" Color:[UIColor whiteColor] Font:17 textAlignment:1]];
        
        //账号输入框
        self.usernameTextField = [XYFactory createTextFieldWithFrame:CGRectMake(65, 83, 245, 23) color:nil type:UITextBorderStyleNone placeholder:@"账号"];
        [self addSubview:_usernameTextField];
        _usernameTextField.delegate = self;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        _usernameTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _usernameTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        self.passwordTextField = [XYFactory createTextFieldWithFrame:CGRectMake(65, 157, 245, 23) color:nil type:UITextBorderStyleNone placeholder:@"密码"];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self addSubview:_passwordTextField];
        _passwordTextField.delegate = self;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        _dataArray = [[NSMutableArray alloc] init];
        self.tableView = [XYFactory createTableViewWithFrame:CGRectMake(45, 106, 245, 110) style:UITableViewStylePlain delegate:self];
        [self addSubview:_tableView];

        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
        _tableView.layer.cornerRadius = 3;
        _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
        _tableView.layer.shadowOffset = CGSizeMake(-1, 4);
        _tableView.layer.shadowOpacity = 0.5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.hidden = YES;

    }
    return self;
}



- (void)textFieldDidChange:(UITextField*)textField {
    NSString * text = @"";
    for (int i=0; i<textField.text.length; i++) {
        NSString * b = [textField.text substringWithRange:NSMakeRange(i, 1)];
        int a = [textField.text characterAtIndex:i];
        if (![b isEqualToString:@" "] && !(a > 0x4e00 && a < 0x9fff)) {
            text = [text stringByAppendingString:b];
        }
    }
    textField.text = text;
    
    
    if (textField == _usernameTextField) {
        if (textField.text.length > 0) {
            self.tableView.hidden = NO;
            [_dataArray removeAllObjects];
            NSArray * sqlArray = [[XYSqlManager defaultService] selectTableName:TABLE_EmailSuffix parameters:@[@"*"] where:nil];
            
            NSArray * arr = [_usernameTextField.text componentsSeparatedByString:@"@"];
            NSString * a1 = [arr objectAtIndex:0];
            if (arr.count > 1) {
                NSString * a2 = [arr objectAtIndex:1];
                
                for (MDEmailSuffix * suffix in sqlArray) {
                    if (suffix.suffix.length > a2.length) {
                        NSString * x2 = [suffix.suffix substringWithRange:NSMakeRange(1, a2.length)];
                        if ([x2 isEqualToString:a2]) {
                            NSString * str = [NSString stringWithFormat:@"%@%@",a1,suffix.suffix];
                            [_dataArray addObject:str];
                        }
                    }
                }
            }else {
                for (MDEmailSuffix * suffix in sqlArray) {
                    NSString * str = [NSString stringWithFormat:@"%@%@",a1,suffix.suffix];
                    [_dataArray addObject:str];
                }
            }
            if (_dataArray.count > 0) {
                [self.tableView reloadData];
            }else {
                self.tableView.hidden = YES;
            }
            
        }else {
            self.tableView.hidden = YES;
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _usernameTextField) {
        [_passwordTextField becomeFirstResponder];
    }else {
        [self.loginBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        UIView * line = [XYFactory createViewWithFrame:CGRectMake(10, 29, 225, 1) color:[UIColor colorWithWhite:0 alpha:0.3]];
        [cell.contentView addSubview:line];
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _usernameTextField.text = [_dataArray objectAtIndex:indexPath.row];
    self.tableView.hidden = YES;
}

@end
