//
//  XYPhotosViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-26.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPhotosViewController.h"
#import "XYPhotosDetailViewController.h"

@interface XYPhotosViewController ()
{
    NSMutableArray * _dataArray;
    int _pageCount;
    int _page;
}
@end

@implementation XYPhotosViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    
    [[self.xNavigationBar.items objectAtIndex:2] addTarget:self action:@selector(clickNavigationRefreshButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.xView.frame = CGRectMake(MENU_WIDTH, NAVIGATION_HEIGHT, H_WIDTH-MENU_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT);
    self.xToolBar.hidden = YES;
    
    //创建瀑布流
    _waterView = [[TMQuiltView  alloc] initWithFrame:CGRectMake((QUILT_CELL_GAP_H-5)/2, 0, H_WIDTH-MENU_WIDTH-(QUILT_CELL_GAP_H-5), H_HEIGHT-NAVIGATION_HEIGHT)];
    _waterView.delegate = self;
    _waterView.dataSource = self;
    _waterView.backgroundColor = [UIColor clearColor];
    [self.xView  addSubview:_waterView];

    CGSize viewSize = _waterView.bounds.size;
    _refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -viewSize.height, viewSize.width, viewSize.height)];
    _refreshTableFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, viewSize.height, viewSize.width, viewSize.height)];
    _refreshTableHeaderView.delegate = self;
    _refreshTableFooterView.delegate = self;
    
    [_waterView addSubview:_refreshTableHeaderView];
    [_waterView addSubview:_refreshTableFooterView];
    
    //创建刷新失败视图
    _xRefreshFailView = [[XYRefreshView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_xRefreshFailView];
    _xRefreshFailView.hidden = YES;
    [self.xView bringSubviewToFront:_xRefreshFailView];
    
    //获取第一页数据
    _page = _pageCount = 1;
    [self getImageListWithPage:_page];
}







#pragma mark - 点击
///点击导航刷新按钮
- (void)clickNavigationRefreshButton:(UIButton *)btn {
    [self getImageListWithPage:1];
}
//点击某cell时调用
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    XYPhotosDetailViewController * vc = [[XYPhotosDetailViewController alloc] init];
    vc.imageListArray = _dataArray;
    vc.image = [_dataArray objectAtIndex:indexPath.row];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 解析
///使用网络/sql数据
- (void)getImageListWithPage:(int)page {
    if (self.netStatus) {//获取数据
        [self getNetPhotosWithPage:page];
    }else { //获取数据库数据
        [self getSqlPhotosWithPage:page netStatus:NO];
    }
}


///网络获取数据
- (void)getNetPhotosWithPage:(int)page {
    _isLoading = YES;
    if (page == 1) {//如果获取第一页(刷新)//删除所有数据
        [self RefreshAddAnimation];
        _page = 1;
    }

    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.3",@"mode",
                                 @"2",@"company_id",
                                 [NSString stringWithFormat:@"%d",page],@"page",
                                 @"250",@"img_width",nil];
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        
        //删除sql页面数据
        if (page == 1) {
            [[XYSqlManager defaultService] deleteFromTableName:TABLE_Photos where:nil];
        }else {
            [[XYSqlManager defaultService] deleteFromTableName:TABLE_Photos where:[NSString stringWithFormat:@"page = \"%d\"",page]];
        }
        
        
        //插入sql数据
        NSArray * imageList = [[[root elementsForName:@"img_list"] firstObject] elementsForName:@"img"];
        for (int i=0; i<imageList.count; i++) {
            GDataXMLElement * element = [imageList objectAtIndex:i];
            MDImage * imageItem = [[MDImage alloc] initWithElement:element];
            imageItem.page = [NSString stringWithFormat:@"%d",page];
            if (![[XYSqlManager defaultService] insertItem:imageItem]) {
                NSLog(@"图集列表,item插入失败");
            }
        }
        
        ///查询sql
        [self getSqlPhotosWithPage:page netStatus:YES];
        
        ///获取总页数
        NSString * string=[[[root elementsForName:@"allpage"] firstObject] stringValue];
        _pageCount = [string intValue];
        
    } falid:^(NSString *errorMsg) {
        [self getSqlPhotosWithPage:page netStatus:NO];
    }];
}

///数据库获取数据
- (void)getSqlPhotosWithPage:(int)page netStatus:(BOOL)status {
    
    NSArray * arr = [[XYSqlManager defaultService] selectTableName:TABLE_Photos parameters:@[@"*"] where:[NSString stringWithFormat:@"page = \"%d\"",page]];
    if (page == 1) {
        [_dataArray removeAllObjects];
        [self RefreshCloseAnimation];
    }
    
    if (arr.count >0) {//有数据
        _page= page+1;
        [_dataArray addObjectsFromArray:arr];
        
        if (page == 1) {//如果获取首页信息->转到顶
            _waterView.contentOffset = CGPointMake(0, 0);
        }
        
        if (!status) {
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_CACHE duration:1.5];
        }
    }
    else {//无数据
        if (page == 1) {
            if (status) {
                [_xRefreshFailView showRefreshViewIsOK:NO title:REQUEST_MESSAGE_NONE subTitle:nil];
            }else {
                [_xRefreshFailView showRefreshViewIsOK:NO title:REQUEST_MESSAGE_FAIL subTitle:@"请检查网络后点击“刷新”按钮，刷新新闻列表"];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"网络连接失败,请检查网络" duration:1.5];
        }
    }
    
    _isLoading = NO;
    if (status) {
        [self reloadEnd];
    }else {
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
        _pageCount = ([[XYSqlManager defaultService] selectCountWithTableName:TABLE_Photos where:nil]+14)/15;
    }
    
}









#pragma mark - TMQuiltView DataSource
//返回数据条数
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView
{
    return _dataArray.count;
}

- (TMQuiltViewCell  *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString  *identifierStr = @"photoIdentifier";
    XYQuiltViewCell  *cell = (XYQuiltViewCell  *)[quiltView  dequeueReusableCellWithReuseIdentifier:identifierStr];
    if (!cell) {
        cell = [[XYQuiltViewCell  alloc] initWithReuseIdentifier:identifierStr];
    }
    MDImage * image = [_dataArray objectAtIndex:indexPath.row];
    cell.image = image;
    return cell;
}

#pragma mark -TMQuiltView Delegate
//返回几列
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView
{
    return 3;
}
//返回某cell高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataArray.count) {
        MDImage * image = [_dataArray objectAtIndex:indexPath.row];
        return [XYQuiltViewCell cellHeightWithImage:image];
    }
    return 288/(100/200.)+QUILT_TITLE_HEIGHT;
}


















#pragma mark - EGO
- (void)reloadEnd {
    
    [_waterView reloadData];
    [_refreshTableFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_waterView];
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_waterView];
    
    CGSize size = _waterView.contentSize;
    CGRect frame = _refreshTableFooterView.frame;
    if (size.height<_waterView.bounds.size.height) {
        size.height = _waterView.bounds.size.height;
    }
    frame.origin.y = size.height;
    _refreshTableFooterView.frame = frame;
    
}


- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view {
    return _isLoading;
}


- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshHeader) {//刷新
        [self getImageListWithPage:1];
    }
    else {//加载更多
        if (_page > 0 && _page <= _pageCount) {
            [self getImageListWithPage:_page];
        }else {
            if (self.netStatus) {
                [SVProgressHUD showErrorWithStatus:@"没有更多图集了" duration:1.5f];
            }else {
                [SVProgressHUD showErrorWithStatus:@"没有更多缓存图集了" duration:1.5f];
            }
            [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshTableFooterView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshTableFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView *)view {
    return [NSDate date];
}



@end
