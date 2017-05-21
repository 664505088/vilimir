
//
//  XYRefreshViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-17.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRefreshViewController.h"

@interface XYRefreshViewController ()

@end

@implementation XYRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航
    for (UIButton* btn in self.xNavigationBar.items) {
        btn.hidden = YES;
    }
    
    for (int i=0; i<self.xToolBar.items.count; i++) {
        UIButton * btn = [self.xToolBar.items objectAtIndex:i];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"news_tool11"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"news_tool12"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickToolBarbackButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            btn.hidden = YES;
        }
    }

    
    self.tableView.transform = CGAffineTransformIdentity;
    self.tableView.frame = self.xView.bounds;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    CGSize viewSize = self.tableView.bounds.size;
    self.refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -viewSize.height, viewSize.width, viewSize.height)];
    self.refreshTableFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, viewSize.height, viewSize.width, viewSize.height)];
    _refreshTableHeaderView.delegate = self;
    _refreshTableFooterView.delegate = self;
    
    [self.tableView addSubview:_refreshTableHeaderView];
    [self.tableView addSubview:_refreshTableFooterView];
}



- (void)clickToolBarbackButton:(UIButton*)btn {
    [SVProgressHUD dismiss];
    [RequestService defaultService];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)reloadData {

    
    [self.tableView reloadData];
    self.isLoading = NO;
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [_refreshTableFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    CGSize size = self.tableView.contentSize;
    CGRect frame = _refreshTableFooterView.frame;
    if (size.height<self.tableView.bounds.size.height) {
        size.height = self.tableView.bounds.size.height;
    }
    frame.origin.y = size.height;
    _refreshTableFooterView.frame = frame;
    
}


#pragma mark - EGO
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view {
    return self.isLoading;
}


- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [super scrollViewDidScroll:scrollView];
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshTableFooterView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshTableFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView *)view {
    return [NSDate date];
}

@end
