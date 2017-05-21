//
//  XYFactory.h
//  XYFramework
//
//  Created by farben on 13-11-20.
//  Copyright (c) 2013年 Shoo. All rights reserved.
//

#import <Foundation/Foundation.h>

///颜色
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.0]

#define FONT_BOLD(s) [UIFont fontWithName:@"OriyaSangamMN-Bold" size:(s)]

#define DEBUG_TEST 0

@interface XYFactory : NSObject







#pragma mark - UILabel
+ (UILabel*)createLabelWithText:(NSString*)text Color:(UIColor*)color;

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text;

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Font:(float)font;

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Color:(UIColor*)textColor Font:(float)font;

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Color:(UIColor*)textColor Font:(float)font textAlignment:(NSInteger)textAlignment;










#pragma mark - UIButton
+ (UIButton*)createButtonImage:(NSString*)normalImage;

+ (UIButton*)createButtonWithFrame:(CGRect)frame Image:(NSString*)normalImage;

+ (UIButton*)createButtonWithFrame:(CGRect)frame Image:(NSString*)normalImage Image:(NSString*)highlighted;

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title buttonWithType:(UIButtonType)UIButtonType;

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title backGroundColor:(UIColor*)bgColor buttonWithType:(UIButtonType)UIButtonType;










#pragma mark - UIImageView
+ (UIImageView*)createImageViewWithCornerRadius:(float)cornerRadius;

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame Image:(NSString*)image;

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame Image:(NSString*)normalImage Image:(NSString*)highlighted;








#pragma mark - UIView

+ (UIView*)createViewWithColor:(UIColor*)color;

+ (UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color;







#pragma mark - TextField
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                             placeholder:(NSString*)placeholder
                       isSecureTextEntry:(BOOL)isSecureTextEntry;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                    type:(UITextBorderStyle)style
                             placeholder:(NSString*)placeholder;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                             placeholder:(NSString*)placeholder;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                   color:(UIColor*)color
                                   image:(NSString*)imageName
                                   style:(UITextBorderStyle)style
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate;







#pragma mark - TextView
+ (UITextView*)createTextViewWithFrame:(CGRect)frame
                                 color:(UIColor*)color
                                 style:(UIKeyboardType)style
                           placeholder:(NSString*)placeholder
                              delegate:(id<UITextViewDelegate>)delegate;




#pragma mark - ScrollView
+ (UIScrollView*)createScrollViewWithFrame:(CGRect)frame
                                 color:(UIColor*)color
                                 contentSize:(CGSize)size
                              delegate:(id<UIScrollViewDelegate>)delegat;


#pragma mark - TableView
+ (UITableView*)createTableViewWithFrame:(CGRect)frame
                                   style:(UITableViewStyle)style
                                delegate:(id<UITableViewDataSource,UITableViewDelegate>)delegate;


+ (UITableView*)createTableViewWithFrame:(CGRect)frame
                              horizontal:(BOOL)isHorizontal
                                   style:(UITableViewStyle)style
                                delegate:(id<UITableViewDataSource,UITableViewDelegate>)delegate;
@end
