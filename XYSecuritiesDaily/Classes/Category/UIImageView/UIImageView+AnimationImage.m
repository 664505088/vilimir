//
//  UIImageView+AnimationImage.m
//  XYGLKKitTest
//
//  Created by YuanLe on 14-4-14.
//  Copyright (c) 2014年 YuanLe. All rights reserved.
//

#import "UIImageView+AnimationImage.h"
#import <ImageIO/ImageIO.h>
@implementation UIImageView (AnimationImage)
- (void)setAnimationData:(NSData*)data {
    double total = 0;
    NSTimeInterval gifAnimationDuration;
    NSMutableArray * frames;
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t l = CGImageSourceGetCount(src);
    if (l > 1){
        frames = [NSMutableArray arrayWithCapacity: l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *dict = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, 0, NULL);
            if (dict){
                NSLog(@"dict");
                NSDictionary *tmpdict = [dict objectForKey: @"{GIF}"];
                total += [[tmpdict objectForKey: @"DelayTime"] doubleValue] * 100;
            }
            if (img) {
                NSLog(@"img");
                [frames addObject: [UIImage imageWithCGImage: img]];
                CGImageRelease(img);
            }
        }
    }
    gifAnimationDuration = total / 100;
    self.animationImages = frames;
    self.animationDuration = gifAnimationDuration;
    [self startAnimating];
    
}
@end
