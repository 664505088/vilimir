//
//  XYPhotosDetailViewController.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"

#import "MDImage.h"
#import "MDPhotoDetail.h"



#import "XYPhotoDetailCell.h"
#import "XYPageIndexControl.h"    //显示页码
#import "XYRefreshTableHeadView.h"
#import "XYRefreshTableFootView.h"//加载更多

#import "XYShareViewController.h"//分享
#import "XYPhotoCommentViewController.h"//跟帖

@interface XYPhotosDetailViewController : XYTableViewController
{
    XYPageIndexControl      *_pageControl;
    XYRefreshTableHeadView  *_refreshTableHeadView;
    XYRefreshTableFootView  *_refreshTableFootView;
    
    UIButton                *_genTieButotn;
    BOOL           _isLoading;
    BOOL                    _isCollect;
    
}

@property (nonatomic, strong)MDImage * image;
@property (nonatomic, strong)NSMutableArray * imageListArray;

@end
