//
//  XYPhotoCommentViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-24.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRefreshViewController.h"

#import "XYPhotosCommentCell.h"

#import "XYPCEditViewController.h"

@interface XYPhotoCommentViewController : XYRefreshViewController
<XYCommentEditViewControllerDelegate>

@property (nonatomic, strong)MDImage * image;
@property (nonatomic, strong)MDPhotoDetail  * photoDetail;


@end
