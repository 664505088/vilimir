//
//  XYRefreshViewController.h
//  XYSecuritiesDaily
//  基于tableViewController(附加上拉,下拉刷新)
//  Created by xiwang on 14-6-17.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTableViewController.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
@interface XYRefreshViewController : XYTableViewController
<EGORefreshTableDelegate>



@property (nonatomic, strong)EGORefreshTableHeaderView *refreshTableHeaderView;
@property (nonatomic, strong)EGORefreshTableFooterView *refreshTableFooterView;
@property (nonatomic, assign)BOOL                      isLoading;


- (void)reloadData;
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos;

@end
