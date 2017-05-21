//
//  XYDetailViewController.h
//  SecuritiesDaily
//  新闻详情
//  Created by xiwang on 14-5-23.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"


#import "UIWebView+FontSize.h"
#import "UIWebView+Touches.h"

#import "XYAdvertisementViewController.h"
#import "XYNewsCommentViewController.h"
#import "XYShareViewController.h"
@interface XYDetailViewController : XYViewController
{
    MDNewsDetail * _newsDetail;
    int _clickCount;
}
@property (nonatomic) BOOL hideEditItem;
@property (nonatomic, strong) MDNew * news;//MDNews/MDHeadNews


@end
