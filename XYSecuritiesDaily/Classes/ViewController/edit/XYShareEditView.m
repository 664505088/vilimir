//
//  XYShareEditView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYShareEditView.h"

@implementation XYShareEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //视图背景
        UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.bounds Image:nil];
        UIImage * image = [UIImage imageNamed:@"info_bg1"];
        loginBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self addSubview:loginBg];
        
        UILabel * title = [XYFactory createLabelWithFrame:CGRectMake(100, 10, self.bounds.size.width-200, 35) Text:@"分享" Color:nil Font:32 textAlignment:1];
        [self addSubview:title];
        
        
        _sizeLabel = [XYFactory createLabelWithFrame:CGRectMake(20, 15, 100, 25) Text:@"0/140" Font:20];
        [self addSubview:_sizeLabel];
        
        
        
        
        //分割线
        for (int i=0; i<15; i++) {
            UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(0, 100+i*35, self.bounds.size.width, 1) Image:nil];
            line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [self addSubview:line_H];
        }
        
        UIView * line_V = [XYFactory createViewWithFrame:CGRectMake(25, 55, 2, self.bounds.size.height-55) color:COLOR_RGB(240, 236, 222)];
        [self addSubview:line_V];
        
        self.textView = [XYFactory createTextViewWithFrame:CGRectMake(0, 55, self.bounds.size.width, self.bounds.size.height-55) color:nil style:UIKeyboardTypeDefault placeholder:nil delegate:self];
        _textView.font = [UIFont systemFontOfSize:30];
        [self addSubview:_textView];
        
        self.rightButton = [XYFactory createButtonWithFrame:CGRectMake(self.bounds.size.width-50, 12.5, 30, 30) Image:@"edit_button_save1" Image:@"edit_button_save2"];
        [self addSubview:_rightButton];
//        [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
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

@end
