//
//  XYPCEditViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-25.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"

#import "MDPhotoDetail.h"

#import "XYCommentEditViewControllerDelegate.h"

#import "XYLoginViewController.h"

@interface XYPCEditViewController : XYChildViewController
<UITextViewDelegate,UIAlertViewDelegate,XYLoginViewDelegate>

@property (nonatomic, strong)MDComment  * comment;

@property (nonatomic, strong)MDImage    * image;

@property (nonatomic, assign) id <XYCommentEditViewControllerDelegate> delegate;


@end
