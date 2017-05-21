//
//  UIImage+Tailor.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tailor)
//改变图片大小
- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height ;

//合并图片
-(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

//裁剪部分图片
-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;


///logo生成默认图
- (UIImage*)createNormalImageWithImageSize:(CGSize)imageSize
                           backgroundColor:(UIColor*)color
                                  logoSize:(CGSize)logoSize;
@end
