//
//  XYEpaperViewController.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-25.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"

#import "MDEpaper.h"
#import "XYEpaperLayoutCell.h"

#import "XYAdvertisementViewController.h"//广告
#import "XYSmallEpaperViewController.h"
#import "XYEpaperDetailViewController.h"
#import "XYEpaperNavigationViewController.h"//版面导航
#import "XYEpaperCalendarViewController.h"//查看往期

@interface XYEpaperViewController : XYTableViewController
<XYEpaperDateDelegate,XYEpaperVersionDelegate>
{
    UIImageView * _adView;
    UIButton * _navigationButton;//版面导航
    UIButton * _historyButton;//往期
    MDAdvertisement * _advertisement;//广告
    UILabel * _dateLabel;
    
    BOOL _isFirst;
}


@property (nonatomic,copy)NSString * year;//版面
@property (nonatomic,copy)NSString * month;//版面
@property (nonatomic,copy)NSString * day;//版面
@end
