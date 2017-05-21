//
//  XYFactory.m
//  XYFramework
//
//  Created by farben on 13-11-20.
//  Copyright (c) 2013年 Shoo. All rights reserved.
//

#import "XYFactory.h"

@implementation XYFactory


#pragma mark - UILabel

+ (UILabel*)createLabelWithText:(NSString*)text Color:(UIColor*)color{
    return [self createLabelWithFrame:CGRectZero Text:text Color:color Font:0];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text {
    return [self createLabelWithFrame:frame Text:text Color:nil Font:0];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Font:(float)font {
    return [self createLabelWithFrame:frame Text:text Color:nil Font:font];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Color:(UIColor*)textColor Font:(float)font {
    return [self createLabelWithFrame:frame Text:text Color:textColor Font:font textAlignment:0];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Color:(UIColor*)textColor Font:(float)font textAlignment:(NSInteger)textAlignment {
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    if (text != nil) {
        label.text = text;
    }
    if (textColor != nil) {
        label.textColor = textColor;
    }
    if (font > 0) {
        label.font = [UIFont systemFontOfSize:font];
    }
    if (textAlignment >= 0 && textAlignment<= 3) {
        label.textAlignment = textAlignment;
    }
    label.backgroundColor = [UIColor clearColor];
    return label;
}





#pragma mark - UIButton
+ (UIButton*)createButtonImage:(NSString*)normalImage {
    return [self createButtonWithFrame:CGRectZero Image:normalImage Image:nil];
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame Image:(NSString*)normalImage {
    return [self createButtonWithFrame:frame Image:normalImage Image:nil];
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame Image:(NSString*)normalImage Image:(NSString*)highlighted {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (normalImage!= nil && ![normalImage isEqualToString:@""]) {
        [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        
//        [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    }
    if (highlighted != nil && ![highlighted isEqualToString:@""]) {
        [button setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
//        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    return button;
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title buttonWithType:(UIButtonType)UIButtonType {
    return [self createButtonWithFrame:frame Title:title backGroundColor:[UIColor clearColor] buttonWithType:UIButtonType];
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title backGroundColor:(UIColor*)bgColor buttonWithType:(UIButtonType)UIButtonType {
    UIButton * button = [UIButton buttonWithType:UIButtonType];
    button.frame = frame;
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    return button;
}


#pragma mark - UIImageView

+ (UIImageView*)createImageViewWithCornerRadius:(float)cornerRadius {
    UIImageView * imageView = [self createImageViewWithFrame:CGRectZero Image:nil Image:nil];
    if (cornerRadius >0) {
        imageView.layer.cornerRadius = cornerRadius;
    }
    return imageView;
}

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame Image:(NSString*)image {
    return [self createImageViewWithFrame:frame Image:image Image:nil];
}

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame Image:(NSString*)normalImage Image:(NSString*)highlighted {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    if (normalImage) {
        [imageView setImage:[UIImage imageNamed:normalImage]];
    }
    if (highlighted) {
        [imageView setHighlightedImage:[UIImage imageNamed:highlighted]];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
    }
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}


#pragma mark - UIView
+ (UIView*)createViewWithColor:(UIColor*)color {
    return [self createViewWithFrame:CGRectZero color:color];
}

+ (UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color {
    UIView * view = [[UIView alloc] initWithFrame:frame];
    if (color) {
        view.backgroundColor = color;
    }
    else {
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}



#pragma mark - TextField

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame {
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    return textField;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                             placeholder:(NSString*)placeholder
                       isSecureTextEntry:(BOOL)isSecureTextEntry {
    UITextField * textField = [self createTextFieldWithFrame:frame color:color type:UITextBorderStyleRoundedRect placeholder:placeholder];
    textField.secureTextEntry = isSecureTextEntry;
    return textField;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame color:(UIColor*)color type:(UITextBorderStyle)style placeholder:(NSString*)placeholder{
    return [self createTextFieldWithFrame:frame color:color image:nil style:style placeholder:placeholder delegate:nil];
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                             placeholder:(NSString*)placeholder {
    return [self createTextFieldWithFrame:frame
                                    color:color
                                    image:imageName
                              placeholder:placeholder
                                 delegate:nil];
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate {
    return [self createTextFieldWithFrame:frame color:color image:imageName style:-1 placeholder:placeholder delegate:delegate];
}
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                                   style:(UITextBorderStyle)style
                            placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate {
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (color) {
        textField.textColor = color;
    }
    if (style>=0) {
        textField.borderStyle = style;
    }
    if (imageName) {
        textField.background = [UIImage imageNamed:imageName];
    }
    if (delegate) {
        textField.delegate = delegate;
    }
    textField.backgroundColor = [UIColor clearColor];
    return textField;
}


#pragma mark - TextView
+ (UITextView*)createTextViewWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   style:(UIKeyboardType)style
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextViewDelegate>)delegate {
    UITextView * textView = [[UITextView alloc] initWithFrame:frame];
    textView.backgroundColor = [UIColor clearColor];
    
    if (color) {
        textView.textColor = color;
    }
    if (style>=0) {
        textView.keyboardType = style;
    }

    if (delegate) {
        textView.delegate = delegate;
    }
    
    if (placeholder.length > 0) {
        UILabel *placeholderLabel = [self createLabelWithFrame:CGRectMake(10, 10, frame.size.width, 20)
                                                          Text:placeholder
                                                         Color:[UIColor grayColor]
                                                          Font:-1];
        placeholderLabel.tag = 10;
        placeholderLabel.numberOfLines = 0;
        [textView addSubview:placeholderLabel];
        [textView sendSubviewToBack:placeholderLabel];
    }

    
    return textView;
}


#pragma mark - ScrollView
+ (UIScrollView*)createScrollViewWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                             contentSize:(CGSize)size
                                delegate:(id<UIScrollViewDelegate>)delegat {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    if (color) {
        scrollView.backgroundColor = color;
    }
    scrollView.contentSize = size;
    if (delegat) {
        scrollView.delegate = delegat;
    }
    return scrollView;
}


#pragma mark - TableView
+ (UITableView *)createTableViewWithFrame:(CGRect)frame
                                    style:(UITableViewStyle)style
                                 delegate:(id<UITableViewDataSource,UITableViewDelegate>)delegate {
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame
                               horizontal:(BOOL)isHorizontal
                                    style:(UITableViewStyle)style
                                 delegate:(id<UITableViewDataSource,UITableViewDelegate>)delegate {
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    if (isHorizontal) {
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.transform = CGAffineTransformMakeRotation(-1.5707963);
        tableView.frame = frame;
    }
    return tableView;
}

@end
