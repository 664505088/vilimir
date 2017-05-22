//
//  UILabel+FitView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-8.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "UILabel+FitView.h"

@implementation UILabel (FitView)
+ (NSRange)rangeToFitWithSize:(CGSize)s
                         text:(NSString *)t
                         font:(UIFont *)font {
    if (t == nil) {
        return NSMakeRange(NSNotFound, 0);
    }
    NSString * text = [t copy];
    for (int i=1; i<=text.length; i++) {
        NSString * str = [text substringWithRange:NSMakeRange(0, i)];
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(s.width, 10000)];
//        NSLog(@"%d / %d     height: %.f / %.f",i,t.length,size.height,s.height);
        if (size.width <= s.width && size.height <= s.height) {
//            NSLog(@"%d / %d",i,t.length);
        }else {
            return NSMakeRange(0, i-1);
        }
    }
    return NSMakeRange(0, t.length);
}
- (NSInteger)textToTit {
    
    NSRange range = [UILabel rangeToFitWithSize:self.frame.size text:self.text font:self.font];
    if (range.length > 0 && range.location!=NSNotFound) {
        self.text = [self.text substringWithRange:range];
        return self.text.length;
    }
    return self.text.length;
}


- (void)horizontalText {
    NSString * text = self.text;
    NSString * tmp = @"";
    for (int i=0; i<text.length; i++) {
        tmp = [tmp stringByAppendingFormat:@"%@\n",[text substringWithRange:NSMakeRange(i, 1)]];
    }
    if (![tmp isEqualToString:@""]) {
        self.text = tmp;
    }
}
@end
