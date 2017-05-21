//
//  UIImage+Tailor.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "UIImage+Tailor.h"

@implementation UIImage (Tailor)





- (UIImage*)transformWidth:(CGFloat)width
					height:(CGFloat)height {
	
	CGFloat destW = width;
	CGFloat destH = height;
	CGFloat sourceW = width;
	CGFloat sourceH = height;
	
	CGImageRef imageRef = self.CGImage;
	CGContextRef bitmap = CGBitmapContextCreate(NULL,
												destW,
												destH,
												CGImageGetBitsPerComponent(imageRef),
												4*destW,
												CGImageGetColorSpace(imageRef),
												(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
	
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *resultImage = [UIImage imageWithCGImage:ref];
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return resultImage;
}

//合并图片
-(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}


//裁剪部分图片
-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}



///logo生成默认图
- (UIImage*)createNormalImageWithImageSize:(CGSize)imageSize
                           backgroundColor:(UIColor*)color
                                  logoSize:(CGSize)logoSize {
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    [self drawInRect:CGRectMake((imageSize.width-logoSize.width)/2, (imageSize.height-logoSize.height)/2, logoSize.width, logoSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
