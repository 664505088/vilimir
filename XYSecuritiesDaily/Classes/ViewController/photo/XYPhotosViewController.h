//
//  XYPhotosViewController.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-26.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYViewController.h"

#import "MDImage.h"

#import "TMQuiltView.h"
#import "XYQuiltViewCell.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "XYRefreshView.h"

@interface XYPhotosViewController : XYViewController
<TMQuiltViewDelegate,TMQuiltViewDataSource,EGORefreshTableDelegate>

{
    TMQuiltView                 *_waterView;
    EGORefreshTableHeaderView   *_refreshTableHeaderView;
    EGORefreshTableFooterView   *_refreshTableFooterView;
    BOOL                        _isLoading;
    
    XYRefreshView               *_xRefreshFailView;
}

@end
