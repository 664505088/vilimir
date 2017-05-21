//
//  XYNewsCommentViewController.h
//  XYSecuritiesDaily
//  新闻跟帖列表
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRefreshViewController.h"


#import "MDNew.h"
#import "XYNewsCommentCell.h"

#import "XYNCEditViewController.h"

@interface XYNewsCommentViewController : XYRefreshViewController
<XYCommentEditViewControllerDelegate>
@property (nonatomic, strong)MDNew * news;
@property (nonatomic, strong)UILabel * commentCountLabel;
@end
