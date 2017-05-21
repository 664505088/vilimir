//
//  XYEditInfoView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEditInfoView.h"

@implementation XYEditInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * redactBg = [XYFactory createImageViewWithFrame:self.bounds Image:@"info_bg2"];
        [self addSubview:redactBg];
        
        
        //保存按钮
        self.rightButton = [XYFactory createButtonWithFrame:CGRectMake(240, 12, 89, 30) Image:@"info_button_forget1" Image:@"info_button_forget2"];
        [self addSubview:_rightButton];
        
        UILabel * rightButtonText = [XYFactory createLabelWithFrame:_rightButton.bounds Text:@"保存" Color:COLOR_RGB(146,154,155) Font:17 textAlignment:1];
        rightButtonText.tag = SUB_VIEW_TAG;
        [_rightButton addSubview:rightButtonText];
        
        
        
        
        NSArray * imageArray = @[@"info_gentie",@"info_shoucang",@"info_xiaoxi"];
        NSArray * titleArray = @[@"我的跟帖",@"我的收藏",@"我的消息"];
        self.toolButtons = [[NSMutableArray alloc] init];
        for (int i=0; i<3; i++) {
            UIButton * button = [XYFactory createButtonWithFrame:CGRectMake(30+i*110, 433, 60, 53) Image:nil];
            [self addSubview:button];
            [_toolButtons addObject:button];
            
            NSString *imageName1 = [imageArray[i] stringByAppendingString:@"1"];
            NSString *imageName2 = [imageArray[i] stringByAppendingString:@"2"];
            UIImageView * iconImageView = [XYFactory createImageViewWithFrame:CGRectMake(15, 3.5, 30, 30) Image:imageName1];
            iconImageView.highlightedImage = [UIImage imageNamed:imageName2];
            iconImageView.tag = SUB_VIEW_TAG;
            [button addSubview:iconImageView];
            UILabel * titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 33, 60, 20) Text:titleArray[i] Color:[UIColor whiteColor] Font:14 textAlignment:1];
            iconImageView.tag = SUB_VIEW_TAG+1;
            [button addSubview:titleLabel];
        }
        self.scrollView = [XYFactory createScrollViewWithFrame:CGRectMake(0, 55, 340, 377) color:[UIColor clearColor] contentSize:CGSizeMake(340, 530) delegate:nil];
        [self addSubview:_scrollView];
        _scrollView.scrollEnabled = NO;
        
        self.imageView = [XYFactory createImageViewWithFrame:CGRectMake(130, 19.5, 80, 80) Image:@"info_touxiang"];
        [_scrollView addSubview:_imageView];
        _imageView.layer.cornerRadius = 40;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        NSArray * titleArray2 = @[@"昵称",@"电话",@"邮箱",@"密码",@"确认密码"];
        self.textFields = [[NSMutableArray alloc] init];
        for (int i=0; i<5; i++) {
            UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(35, 130+i*50, 40, 25) Text:titleArray2[i] Color:[UIColor grayColor] Font:20 textAlignment:1];
            [_scrollView addSubview:label];
            CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(120, 25)];
            label.frame = CGRectMake(35, 130+i*50, size.width, size.height);
            
            UITextField * textField = [XYFactory createTextFieldWithFrame:CGRectMake(35+size.width+20, 130+i*50, 340-70-size.width-20, size.height) color:nil type:UITextBorderStyleNone placeholder:nil];
            [_scrollView addSubview:textField];
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyNext;
            textField.keyboardAppearance = UIKeyboardAppearanceAlert;
            switch (i) {
                case 1:textField.keyboardType = UIKeyboardTypeASCIICapable;break;
                case 2:textField.enabled = NO;break;
                case 3:textField.secureTextEntry = YES;break;
                case 4:textField.secureTextEntry = YES;textField.returnKeyType = UIReturnKeyDone;break;
            }

            [self.textFields addObject:textField];
            
            UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(35, 160+i*50, 270, 1) Image:nil];
            line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [_scrollView addSubview:line_H];
        }
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    int index =(int) [self.textFields indexOfObject:textField];
    if (index+1<self.textFields.count) {
        UITextField * textFieldNext = [self.textFields objectAtIndex:index+1];
        if (textFieldNext.isEnabled == NO && index+2<self.textFields.count) {
            textFieldNext = [self.textFields objectAtIndex:index+2];
        }
        [textFieldNext becomeFirstResponder];
    }else {
        [self.rightButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

@end
