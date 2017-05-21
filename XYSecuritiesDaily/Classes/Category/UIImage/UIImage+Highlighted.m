//
//  UIImage+Highlighted.m
//  XYNAV
//
//  Created by farben on 14-1-10.
//  Copyright (c) 2014年 Shoo. All rights reserved.
//

#import "UIImage+Highlighted.h"

@implementation UIImage (Highlighted)

- (UIImage *)highlighted {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)
           blendMode:kCGBlendModeDarken
               alpha:0.6];
    UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return highlighted;
}

@end
