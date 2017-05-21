//
//  XYCollectPhotoView.h
//  XYSecuritiesDaily
//  图片收藏表视图
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDImage.h"

#import "TMQuiltView.h"
#import "XYQuiltCollectCell.h"
#import "XYCollectPhotoViewDelegate.h"

@interface XYCollectPhotoView : UIView
<TMQuiltViewDataSource,TMQuiltViewDelegate>

@property (nonatomic, assign)id <XYCollectPhotoViewDelegate>delegate;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)TMQuiltView * waterView;
@end
