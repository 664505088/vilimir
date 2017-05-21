//
//  XYNewViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYNewViewController.h"


@implementation XYNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _headArray = [[NSMutableArray alloc] init];
    
    //给导航按钮添加方法
    [[self.xNavigationBar.items objectAtIndex:2] addTarget:self action:@selector(clickNavigationRefreshButton:) forControlEvents:UIControlEventTouchUpInside];
    ///更改主视图位置大小
    self.xView.frame = CGRectMake(MENU_WIDTH, NAVIGATION_HEIGHT, H_WIDTH-MENU_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT);
    
    //隐藏底部工具栏
    self.xToolBar.hidden = YES;
    self.tableView.pagingEnabled = YES;
    
    //创建广告
    _adView = [XYFactory createImageViewWithFrame:CGRectMake(41, self.xView.bounds.size.height-AD_HEIGHT, 840, AD_HEIGHT) Image:@"normal_advertisement"];
    _adView.backgroundColor = COLOR_RGB(170, 170, 170);
    [self.xView addSubview:_adView];
    UITapGestureRecognizer * adGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdView:)];
    _adView.userInteractionEnabled = YES;
    [_adView addGestureRecognizer:adGesture];
    
    //默认隐藏广告(列表向下移动 广告/2像素)
    _adView.hidden = YES;
    CGRect frame = self.xView.bounds;
    frame.origin.y = AD_HEIGHT/2;
    frame.size.height = NEWSCELL_HEIGHT;
    self.tableView.frame = frame;
    
    //广告页面关闭按钮
    UIButton * closeAdViewBtn = [XYFactory createButtonWithFrame:CGRectMake(_adView.frame.size.width-23, 0.5f, 23, 23) Image:@"icon_advertisem_close_1" Image:@"icon_advertisem_close_2"];
    [_adView addSubview:closeAdViewBtn];
    [closeAdViewBtn addTarget:self action:@selector(clickAdViewCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    closeAdViewBtn.backgroundColor = [UIColor whiteColor];
    //加载更多
    _refreshTableFootView = [[XYRefreshTableFootView alloc] initWithFrame:CGRectMake(0, self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    [self.tableView addSubview:_refreshTableFootView];

    
    //显示页码
    _pageIndexControl = [[XYPageIndexControl alloc] initWithFrame:CGRectMake(365, self.xView.bounds.size.height-50, 200, 30)];
    [self.xView addSubview:_pageIndexControl];
    
    [_pageIndexControl setindex:0 Count:0];
    
    
    //创建页码控制计算器
    _pageControl = [[MDPage alloc] initWithHead:5 page1:8 page2:7];
    _pageControl.has_head = self.newsType.has_head;
    
    //获取菜单数据
    [self getNewsItemsWithPage:1];
}



#pragma mark - 事件
///点击广告
- (void)clickAdView:(UITapGestureRecognizer*)gr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_advertisement.ad_img_url]];
    
//    XYAdvertisementViewController * vc = [[XYAdvertisementViewController alloc] init];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    vc.url = _advertisement.ad_img_url;
//    [self.navigationController pushViewController:vc animated:YES];
}
///点击广告关闭按钮
- (void)clickAdViewCloseButton:(UIButton*)btn {
    [self showOrHideAdvertisement:nil];
}
///点击顶部刷新按钮
- (void)clickNavigationRefreshButton:(UIButton *)btn {
    self.xRefreshFailView.hidden = YES;
    self.tableView.hidden = NO;
    [self getNewsItemsWithPage:1];
}




#pragma mark - 解析


//数据打包
- (NSMutableArray*)arrayZipCount:(NSInteger)count withDataArray:(NSArray *)data {
    NSMutableArray * big = [[NSMutableArray alloc] init];
    for (int i = 0 ; i<(data.count+count-1)/count; i++) {
        NSMutableArray * small = [[NSMutableArray alloc] init];
        NSInteger _c = data.count-i*count >= count ?count:data.count-i*count;
        for (int j = 0; j<_c; j++) {
            
            id obj = [data objectAtIndex:i*count+j];
            [small addObject:obj];
        }
        [big addObject:small];
    }
    return big;
}

///获取新闻列表(获取网络->选择net/sql)
- (void)getNewsItemsWithPage:(int)page {
    if (self.netStatus) {//获取数据
        [self getNetNewsWithPage:page];
    }else { //获取数据库数据
        if (page == 1) {
            [self getSqlHeadNewsWithNews];
        }
        [self getSqlNewsWithPage:page netStatus:NO];
    }
}
///有网络,获取网络数据
- (void)getNetNewsWithPage:(int)page {
    _isLoading = YES;
    if (page == 1) {//如果获取第一页数据//添加刷新动画
        [self RefreshAddAnimation];
    }
    [SVProgressHUD showWithStatus:nil];
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.1",@"mode",
                                 self.newsType.idString,@"column_id",
                                 [NSString stringWithFormat:@"%d",page],@"page",
                                 @"2",@"company_id",
                                 @"1065",@"head_img_width",
                                 @"408",@"img_width",
                                 @"462",@"big_img_width",
                                 @"1680",@"ad_img_width",nil];
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        //插入sql头条
        if (page == 1) {
            //删除原有头条
            NSString * where = [NSString stringWithFormat:@"column_id=\"%@\" ",self.newsType.idString];
            [self.sqlManager deleteFromTableName:TABLE_HeadNews where:where];
            
            
            NSArray * head_list = [[[root elementsForName:@"head_list"] firstObject] elementsForName:@"news"];
            
            //重新添加某菜单下头条
            for (GDataXMLElement * element in head_list) {
                MDHeadNews * headNews = [[MDHeadNews alloc] initWithElement:element];
                headNews.column_id = self.newsType.idString;
                [self.sqlManager insertItem:headNews];
            }
            
            [self getSqlHeadNewsWithNews];
        }
        
        //删除sql原有数据
        NSString * where = [NSString stringWithFormat:@"column_id=\"%@\" and page=\"%d\"",self.newsType.idString,page];
        [self.sqlManager deleteFromTableName:TABLE_News where:where];
        
        //插入sql新闻
        NSArray * newsList = [[[root elementsForName:@"news_list"] firstObject] elementsForName:@"news"];
        for (GDataXMLElement * element in newsList) {
            MDNews * news = [[MDNews alloc] initWithElement:element];
            news.column_id = self.newsType.idString;
            news.page = [NSString stringWithFormat:@"%d",page];
            if (![self.sqlManager insertItem:news]) {
                NSLog(@"%@",[self.sqlManager.dataBase lastError]);
            }
        }
        
        //获取广告
        _advertisement = [[MDAdvertisement alloc] initWithElement:root];
        
        [self showOrHideAdvertisement:_advertisement];
        
        ///获取条数
        NSString* total_count= [[[root elementsForName:@"total_count"] firstObject] stringValue];
        if (total_count!=nil) {
            _pageControl.page = page;
            _pageControl.count = [total_count intValue];
        }
        
        
        //从数据库取数据
        [self getSqlNewsWithPage:page netStatus:YES];
        
       
    } falid:^(NSString *errorMsg) {
        NSLog(@"新闻列表加载失败:%@",errorMsg);
        if (page == 1) {
            [self getSqlHeadNewsWithNews];
        }
        [self getSqlNewsWithPage:page netStatus:NO];
    }];
}
///数据库获取头条
- (void)getSqlHeadNewsWithNews {
    if ([self.newsType.has_head isEqualToString:@"1"]) {
        NSString * where = [NSString stringWithFormat:@"column_id=\"%@\" ",self.newsType.idString];
        NSArray * array = [self.sqlManager selectTableName:TABLE_HeadNews parameters:@[@"*"] where:where];
        [_headArray removeAllObjects];
        [_headArray addObjectsFromArray:array];
    }
}
///数据库新闻
- (void)getSqlNewsWithPage:(int)page netStatus:(BOOL)status {
    ///查询数据库数据
    NSString * where = [NSString stringWithFormat:@"column_id=\"%@\" and page=\"%d\"",self.newsType.idString,page];
    
    NSArray * array = [self.sqlManager selectTableName:TABLE_News parameters:@[@"*"] where:where];
    
    if (page==1) {//如果是第一页
        [self.dataArray removeAllObjects];//删除所有数据
        [self RefreshCloseAnimation];//关闭动画
    }
    [SVProgressHUD dismiss];
    
    //有缓存
    if (array.count > 0) {//有数据
        //为菜单某项添加打包数组
        NSArray * zipArray = [self arrayZipCount:8 withDataArray:array];//数组打散成8-7
    
        [self.dataArray addObjectsFromArray:zipArray];
        
        //刷新
        _isLoading = NO;

        self.tableView.hidden = NO;
        [self.tableView reloadData];

        float bcw = self.tableView.contentSize.height;
        if (bcw == 0) {
            bcw = self.tableView.bounds.size.height;
        }
        CGRect frame = _refreshTableFootView.frame;
        frame.origin.y = bcw;
        _refreshTableFootView.frame = frame;
        
        if (page == 1) {//如果获取首页信息->转到顶
            self.tableView.contentOffset = CGPointMake(0, 0);
        }
        _pageControl.page = page;
        


        
        if (_pageControl.page == 1 && [self.newsType.has_head isEqualToString:@"1"]) {
            if (_pageControl.page+1 <=_pageControl.pageBigMax) {
                [self getNewsItemsWithPage:_pageControl.page+1];
            }
        }
        

        if (!status) {//如果没有网络时候,提示使用缓存
            [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_CACHE duration:1.5];
        }
    }
    //无缓存
    else {
        if (page == 1) {  //如果是首页 显示全屏提示
            self.tableView.hidden = YES;
            [self.xView bringSubviewToFront:self.xRefreshFailView];
            if (status) {
                [self.xRefreshFailView showRefreshViewIsOK:NO title:REQUEST_MESSAGE_NONE subTitle:nil];
            }else {
                [self.xRefreshFailView showRefreshViewIsOK:NO title:REQUEST_MESSAGE_FAIL subTitle:@"请检查网络后点击“刷新”按钮，刷新新闻列表"];
            }
        }
        else {   //如果不是首页 显示提示框提示
            if (status) {
                [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_NONE duration:1.5];
            }else {
                [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1.5];
            }
        }
    }
    
    if (!status) {
        int count = [self.sqlManager selectCountWithTableName:TABLE_News where:[NSString stringWithFormat:@"column_id=\"%@\"",self.newsType.idString]];
        _pageControl.count = count;
    }
    float bw = self.tableView.bounds.size.height;
    float by = self.tableView.contentOffset.y;
    int index = by/bw+1;
    
    int tmp = index/5;
    int count = (tmp+1)*5;
    if (count >_pageControl.pageSmallMax) {
        count = _pageControl.pageSmallMax;
    }
    [_pageIndexControl setindex:index Count:count];
}






#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.xView.bounds.size.width;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * IdentifierNews = @"news";
    XYNewsPageCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierNews];
    if (cell == nil) {
        cell = [[XYNewsPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierNews];
    }
    NSArray * zipArray = [self.dataArray objectAtIndex:indexPath.row];
    BOOL isHasHead = [self.newsType.has_head boolValue];
    [cell setPageArray:zipArray isHasHead:isHasHead headArray:_headArray delegate:self row:(int)indexPath.row];
    return cell;
}




#pragma mark - XYNewsPageSelectedDelegate
///点击某条新闻
- (void)selectedNewsItemAtpage:(int)page withIndex:(int)index {
    [self pushDetailViewControllerWithNews:[[self.dataArray objectAtIndex:page] objectAtIndex:index]];
}
///点击某条头条新闻
- (void)headPageView:(id)headPageView didSelectRowAtIndex:(int)index {
    [self pushDetailViewControllerWithNews:[_headArray objectAtIndex:index]];
}


- (void)pushDetailViewControllerWithNews:(MDNews*)news {
    if (self.netStatus) {
        XYDetailViewController * vc = [[XYDetailViewController alloc] init];
        vc.news = news;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请检查网络" duration:1.5f];
    }
}

#pragma mark - 加载更多
///移动scrollView时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = self.tableView.contentOffset.y+self.tableView.bounds.size.height;
    float width = self.tableView.contentSize.height;
    
    //更改页码(以及位置)
    float bw = self.tableView.bounds.size.height;
    float by = self.tableView.contentOffset.y;
    int index = (by+bw/2)/bw+1;
    
//    [_pageIndexControl setindex:index Count:_pageControl.pageSmallMax];
    
    int tmp = index/5;
    int count = (tmp+1)*5;
    if (count >_pageControl.pageSmallMax) {
        count = _pageControl.pageSmallMax;
    }
    [_pageIndexControl setindex:index Count:count];
    
    
    
    if (x > width && _isLoading == NO) {
        if (_pageControl.page+1 <=_pageControl.pageBigMax) {
            [_refreshTableFootView startWithScrollView:self.tableView];
            [self getNewsItemsWithPage:_pageControl.page+1];
        }else {
            [_refreshTableFootView stopWithTitle:@"没有更多新闻"];
        }
    }
}





#pragma mark - 隐藏/显示广告
- (void)showOrHideAdvertisement:(MDAdvertisement*)adv {
    if (adv!=nil && adv.ad_img != nil && adv.ad_img_url!=nil) {
        _adView.hidden = NO;
        _pageIndexControl.frame = CGRectMake(365, self.xView.bounds.size.height-90, 200, 30);
        [_adView setImageWithURL:[NSURL URLWithString:adv.ad_img] placeholderImage:[UIImage imageNamed:@"normal_advertisement"]];
        
        CGRect frame = self.xView.bounds;
        frame.size.height = NEWSCELL_HEIGHT;
        self.tableView.frame = frame;
    }
    else {
        _pageIndexControl.frame = CGRectMake(365, self.xView.bounds.size.height-53, 200, 30);
        _adView.hidden = YES;
        CGRect frame = self.xView.bounds;
        frame.origin.y = AD_HEIGHT/2;
        frame.size.height = NEWSCELL_HEIGHT;
        self.tableView.frame = frame;
    }
}
@end
