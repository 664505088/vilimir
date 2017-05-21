//
//  XYPhotoDetailCell.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-6.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPhotoDetail.h"
#import "UIImage+Tailor.h"
@interface XYPhotoDetailCell : UITableViewCell
{
    UIImageView  * _grayImgView;
}
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) id <UITableViewDelegate> delegate;
@property (nonatomic, strong) UILabel       * galleryLabel;
@property (nonatomic, strong) UILabel       * descriptLabel;

@property (nonatomic, strong) UILabel       * commentCountLabel;

@property (nonatomic, strong) UIImageView   * imgView;
- (void)setPhotoDetail:(MDPhotoDetail *)photoDetail;
@end
