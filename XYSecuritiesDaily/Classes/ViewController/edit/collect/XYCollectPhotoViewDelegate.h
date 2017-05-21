//
//  XYCollectPhotoViewDelegate.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYCollectPhotoViewDelegate <NSObject>


- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

@end
