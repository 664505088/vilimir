//
//  XYNCEditViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNCEditViewController.h"

@interface XYNCEditViewController ()
{
    BOOL              _isShowKeyBorder;
    UITextView      * _textView;
    UILabel         * _sizeLabel;
}
@end

@implementation XYNCEditViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.xView.frame = CGRectMake(210, STATUS_HEIGHT+55, 600, 600);
    
    //登录视图背景
    UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.xView.bounds Image:nil];
    UIImage * image = [UIImage imageNamed:@"info_bg1"];
    loginBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [self.xView addSubview:loginBg];
    
    
    UILabel * title = [XYFactory createLabelWithFrame:CGRectMake(100, 10, self.xView.bounds.size.width-200, 35) Text:(self.comment?@"跟帖":@"评论") Color:nil Font:32 textAlignment:1];
    [self.xView addSubview:title];
    
    
    _sizeLabel = [XYFactory createLabelWithFrame:CGRectMake(20, 15, 100, 25) Text:@"0/140" Font:20];
    [self.xView addSubview:_sizeLabel];
    

    
    
    //分割线
    for (int i=0; i<15; i++) {
        UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(0, 100+i*35, self.xView.bounds.size.width, 1) Image:nil];
        line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self.xView addSubview:line_H];
    }

    UIView * line_V = [XYFactory createViewWithFrame:CGRectMake(25, 55, 2, self.xView.bounds.size.height-55) color:COLOR_RGB(240, 236, 222)];
    [self.xView addSubview:line_V];
    
    _textView = [XYFactory createTextViewWithFrame:CGRectMake(0, 55, self.xView.bounds.size.width, self.xView.bounds.size.height-55) color:nil style:UIKeyboardTypeDefault placeholder:nil delegate:self];
    _textView.font = [UIFont systemFontOfSize:30];
    [self.xView addSubview:_textView];
    
    UIButton * rightBtn = [XYFactory createButtonWithFrame:CGRectMake(self.xView.bounds.size.width-50, 12.5, 30, 30) Image:@"edit_button_save1" Image:@"edit_button_save2"];
    [self.xView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 解析
- (void)clickRightButton:(UIButton*)btn {
    if (_textView.text == nil || _textView.text.length == 0 || [_textView.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入跟帖内容" duration:2];
    }
    else if ([XYEditManager shardManager].user.isLogin == NO) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil] show];
    }else {
        [self.view endEditing:YES];
        [self getNewsCommentSend];
    }
}





#pragma mark - 解析
- (void)getNewsCommentSend {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"10.2", @"mode",
                                    self.news.idString, @"id",
        [XYEditManager shardManager].user.username, @"mobile_num",//手机版用字段(此处传邮箱:username)
                                        _textView.text, @"detail",
                                    @"2", @"company_id",
                                        @"3",@"from",//1手机/2待定/3pad
                                    nil];
    if (self.comment) {
        [parameters setObject:self.comment.idString forKey:@"comment_id"];
    }else {
        [parameters setObject:@"" forKey:@"comment_id"];
    }
    [SVProgressHUD showWithStatus:@"正在发送跟帖..."];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSString * result = [[[root elementsForName:@"comment_result"] firstObject] stringValue];
        if ([result isEqualToString:@"yes"]) {
            if ([self.delegate respondsToSelector:@selector(commentDidFinish)]) {
                [self.delegate commentDidFinish];
            }
            [self dismissViewControllerAnimated:NO completion:nil];
            [SVProgressHUD dismissWithSuccess:@"跟帖成功,等待审核"];
        }else {
            [SVProgressHUD dismissWithError:@"跟帖失败"];
        }
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD dismissWithError:errorMsg];
    }];

}









#pragma mark - TextViewDelegate
///常常由于联想输入的缘故，会有很多字符一起输入
-(void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    _sizeLabel.text = [NSString stringWithFormat:@"%ld/140",textView.text.length];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([[textView text] length]>140){
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 140)];
        return NO;
    }
    
    //判断是否为删除字符，如果为删除则让执行
    
    char c=[text UTF8String][0];
    if (c=='\000') {
        _sizeLabel.text = [NSString stringWithFormat:@"%ld/140",_textView.text.length];
//        [NSString stringWithFormat:@"%d / 140",MaxNumberOfDescriptionChars-[[textView text] length]+1];
        return YES;
    }
//
    if([[textView text] length]==140) {
        if(![text isEqualToString:@"\b"]){
            _sizeLabel.text = [NSString stringWithFormat:@"%ld/140",_textView.text.length];
            return NO;
        }
    }
    return YES;
    
}



#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        XYLoginViewController * vc = [[XYLoginViewController alloc] init];
        vc.delegate = self;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:NO completion:nil];

    }
}
- (void)loginViewDidFinshed:(XYLoginViewController *)vc {
    [vc.view endEditing:YES];
    [vc clickBlackPoint];
}


@end
