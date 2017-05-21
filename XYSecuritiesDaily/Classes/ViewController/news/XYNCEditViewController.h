//
//  XYNCEditViewController.h
//  XYSecuritiesDaily
//  新闻跟帖
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"

#import "MDNew.h"

#import "XYCommentEditViewControllerDelegate.h"

#import "XYLoginViewController.h"


@interface XYNCEditViewController : XYChildViewController
<UITextViewDelegate,UIAlertViewDelegate,XYLoginViewDelegate>

@property (nonatomic,strong) MDNew * news;
@property (nonatomic,strong) MDComment * comment;

@property (nonatomic, assign) id <XYCommentEditViewControllerDelegate> delegate;
@end
