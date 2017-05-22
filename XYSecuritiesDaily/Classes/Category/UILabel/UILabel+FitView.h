//
//  UILabel+FitView.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-8.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FitView)

+ (NSRange)rangeToFitWithSize:(CGSize)s
                        text:(NSString*)t
                        font:(UIFont*)font;
- (NSInteger)textToTit;


- (void)horizontalText;

@end
