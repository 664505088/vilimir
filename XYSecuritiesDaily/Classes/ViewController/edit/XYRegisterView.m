//
//  XYRegisterView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRegisterView.h"

@implementation XYRegisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = self.bounds.size.width;
        //登录视图背景
        UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.bounds Image:@"info_bg1"];
        [self addSubview:loginBg];
    
   
        
        //返回按钮
        self.backBtn = [XYFactory createButtonWithFrame:CGRectMake(15, 12, 89, 30) Image:@"info_button_forget1" Image:@"info_button_forget2"];
        _backBtn.clipsToBounds = NO;
        [self addSubview:_backBtn];
        
        [_backBtn addSubview:[XYFactory createLabelWithFrame:_backBtn.bounds Text:@"返回" Color:COLOR_RGB(146,154,155) Font:17 textAlignment:1]];
        
        
        //注册
        self.registerBtn = [XYFactory createButtonWithFrame:CGRectMake((width-300)/2, 220, 300, 42.5) Image:@"info_button_okregister1" Image:@"info_button_okregister2"];
        [self addSubview:_registerBtn];
        [_registerBtn addSubview:[XYFactory createLabelWithFrame:_registerBtn.bounds Text:@"确认注册" Color:nil Font:17 textAlignment:1]];
        
        
        NSArray * title = @[@"邮  箱:",@"密  码:",@"确认密码:"];
        for (int i=0; i<3; i++) {
            UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(30, 80+i*50, 80, 25) Text:title[i] Color:[UIColor grayColor] Font:20 textAlignment:1];
            [self addSubview:label];
            [label sizeToFit];
            //分割线
            UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake((width-280)/2, 108+i*50, 280, 1) Image:nil];
            line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [self addSubview:line_H];
        }

        
        
        self.usernameTextField = [XYFactory createTextFieldWithFrame:CGRectMake(120, 80, 190, 23) color:nil type:UITextBorderStyleNone placeholder:nil];
        [self addSubview:_usernameTextField];
        _usernameTextField.delegate = self;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        _usernameTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _usernameTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        self.passwordTextField1 = [XYFactory createTextFieldWithFrame:CGRectMake(120, 130, 190, 23) color:nil type:UITextBorderStyleNone placeholder:nil];
        _passwordTextField1.secureTextEntry = YES;
        _passwordTextField1.delegate = self;
        _passwordTextField1.returnKeyType = UIReturnKeyNext;
        _passwordTextField1.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self addSubview:_passwordTextField1];
        [_passwordTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        self.passwordTextField2 = [XYFactory createTextFieldWithFrame:CGRectMake(120, 180, 190, 23) color:nil type:UITextBorderStyleNone placeholder:nil];
        _passwordTextField2.secureTextEntry = YES;
        _passwordTextField2.delegate = self;
        _passwordTextField2.returnKeyType = UIReturnKeyDone;
        _passwordTextField2.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self addSubview:_passwordTextField2];
        [_passwordTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        _dataArray = [[NSMutableArray alloc] init];
        self.tableView = [XYFactory createTableViewWithFrame:CGRectMake(80, 100, 230, 130) style:UITableViewStylePlain delegate:self];
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

- (void)pushView:(UIView *)view {
    [super pushView:view];
    self.usernameTextField.text = @"";
    self.passwordTextField1.text = @"";
    self.passwordTextField2.text = @"";
}
- (void)pushView:(UIView *)view completion:(void (^)(BOOL))completion {
    [super pushView:view completion:completion];
    self.usernameTextField.text = @"";
    self.passwordTextField1.text = @"";
    self.passwordTextField2.text = @"";
}



- (void)textFieldDidChange:(UITextField*)textField {
    NSString * text = @"";
    for (int i=0; i<textField.text.length; i++) {
        NSString * b = [textField.text substringWithRange:NSMakeRange(i, 1)];
        if (![b isEqualToString:@" "]) {
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
    if (textField == self.usernameTextField) {
        [_passwordTextField1 becomeFirstResponder];
    }else if (textField == self.passwordTextField1) {
        [_passwordTextField2 becomeFirstResponder];
    }else if (textField == self.passwordTextField2) {
        [self.registerBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
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
        UIView * line = [XYFactory createViewWithFrame:CGRectMake(10, 29, 210, 1) color:[UIColor colorWithWhite:0 alpha:0.3]];
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
