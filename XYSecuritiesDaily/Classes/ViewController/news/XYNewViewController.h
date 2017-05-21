//
//  XYNewViewController.h
//  XYSecuritiesDaily
//  新闻列表
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"

#import "MDAdvertisement.h"

#import "XYNewsPageCell.h"

#import "XYDetailViewController.h"

#define AD_HEIGHT 48

@interface XYNewViewController : XYTableViewController
{
    BOOL            _isLoading; //是否正在请求网络
    NSMutableArray * _headArray;//存储头条
    
    MDPage * _pageControl;  //页码计算器
    MDAdvertisement * _advertisement;//新闻model
    
    UIImageView * _adView;//广告
    XYPageIndexControl * _pageIndexControl;//显示页码视图
    XYRefreshTableFootView  *_refreshTableFootView;//右侧家在更多
}
@property (nonatomic,strong)MDNewsType * newsType;//存储栏目信息,由tabbar给传值



@end
