//
//  XYCollectViewController.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"

//#import "MDImage.h"
#import "XYCollectPhotoView.h"
//#import "TMQuiltView.h"
#import "XYCollectTypeView.h"
#import "XYNewsCollectCell.h"
//#import "XYQuiltCollectCell.h"

#import "XYDetailViewController.h"
#import "XYPhotosDetailViewController.h"

//#import "XYQuiltViewCell.h"
@interface XYCollectViewController : XYTableViewController
<XYCollectPhotoViewDelegate>
{
 
    
    XYCollectPhotoView          *_photoView;
    
    XYCollectTypeView           *_collectTypeView;
    
    NSMutableArray              *_lineArray;
  
}

@property (nonatomic, strong) XYRefreshView * xRefreshFailView2;
@end
