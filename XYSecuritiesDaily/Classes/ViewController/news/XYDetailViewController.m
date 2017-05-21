//
//  XYDetailViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-23.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYDetailViewController.h"
#import "XYPageIndexControl.h"

@interface XYDetailViewController ()
<UIWebViewDelegate>
{
    BOOL _isCollect;            //是否被收藏
    NSString * _comment_count;      //跟帖数
    MDAdvertisement * _advertisement; //广告model
    
    UIView * _navigationView; //导航
    UILabel * _commentCountLabel;//跟帖
    UIWebView *_webView;    //网页
    UIImageView * _adView;  //广告
    
}
@end





@implementation XYDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //隐藏导航 logo 如果是从我的收藏进入(隐藏设置,登录)
    self.xNavigationBar.logoImageView.hidden = YES;
    if (self.hideEditItem) {
        UIButton *btn1 = [self.xNavigationBar.items objectAtIndex:0];
        UIButton *btn2 = [self.xNavigationBar.items objectAtIndex:1];
        btn1.hidden = btn2.hidden = YES;
        self.xNavigationBar.logoImageView.hidden = NO;
    }
    [[self.xNavigationBar.items lastObject] addTarget:self action:@selector(clickNavigationRefreshButton:) forControlEvents:UIControlEventTouchUpInside];

    
    //更改工具栏图标
    for (int i=0; i<self.xToolBar.items.count; i++) {
        UIButton * button = [self.xToolBar.items objectAtIndex:i];
        if (i<4) {
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            if (i==3) {
                _isCollect = [self.sqlManager selectCountWithTableName:TABLE_MyCollect where:[NSString stringWithFormat:@"type=\"News\" and column_id=\"%@\" and idString=\"%@\"",self.news.column_id,self.news.idString]];
                if (_isCollect) {
                    [button setImage:[UIImage imageNamed:@"news_tool42"] forState:UIControlStateNormal];
                }
            }
            
        }else {
            button.hidden = YES;
        }
    }
    
    
    
    
    
    //跟帖
    _commentCountLabel = [XYFactory createLabelWithFrame:CGRectZero
                                                    Text:@"0跟帖" Color:[UIColor whiteColor]
                                                    Font:15
                                           textAlignment:1];
    [self.xToolBar addSubview:_commentCountLabel];
    _commentCountLabel.backgroundColor = [UIColor redColor];
    
    _commentCountLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNewsComment:)];
    [_commentCountLabel addGestureRecognizer:gr];
    _commentCountLabel.hidden = YES;
    
    
    //创建广告
    _adView = [XYFactory createImageViewWithFrame:CGRectMake(0, H_HEIGHT-AD_HEIGHT, H_WIDTH, AD_HEIGHT) Image:@"normal_advertisement"];
    [self.view addSubview:_adView];
    UITapGestureRecognizer * adGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdView:)];
    _adView.userInteractionEnabled = YES;
    [_adView addGestureRecognizer:adGesture];
    _adView.hidden = YES;
   
    //广告关闭按钮
    UIButton * closeAdViewBtn = [XYFactory createButtonWithFrame:CGRectMake(_adView.frame.size.width-23, 0.5f, 23, 23) Image:@"icon_advertisem_close_1" Image:@"icon_advertisem_close_2"];
    [_adView addSubview:closeAdViewBtn];
    [closeAdViewBtn addTarget:self action:@selector(clickAdViewCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    closeAdViewBtn.backgroundColor = [UIColor whiteColor];
    
    
    
    //创建网页视图
    _webView = [[UIWebView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_webView];
    _webView.delegate = self;
     _webView.backgroundColor = [UIColor clearColor];
    
    
    
    //获取数据
    [self getNewsDetail];
   
   
    ///增加坚挺字体大小是否改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFontSizeChange:) name:NOTIFICATION_FONT object:nil];
}



- (void)notificationFontSizeChange:(NSNotification*)notification {
    [self performSelector:@selector(xxx) withObject:nil afterDelay:0.2];
    
}
///修改字体大小
- (void)xxx {
    if (self.editManager.fontSize!= XYEditFontSmallSize) {
        [_webView fontSizeToFit:self.editManager.fontSize*7];
    }else {
        [_webView fontSizeToFit:100];
    }
}








#pragma mark - 点击
//进入广告
- (void)clickAdView:(UITapGestureRecognizer *)gr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_advertisement.ad_img_url]];
//    XYAdvertisementViewController * vc = [[XYAdvertisementViewController alloc] init];
//    vc.url = _advertisement.ad_img_url;
//    [self.navigationController pushViewController:vc animated:YES];
}
//关闭广告
- (void)clickAdViewCloseButton:(UIButton*)btn {
    [self showOrHideAdvertisement:nil];
}
//点击顶部按钮
- (void)clickNavigationRefreshButton:(UIButton *)btn {
    if (btn.tag == 2) {//刷新
        [self getNewsDetail];
    }
}



//点击底部按钮
- (void)clickButton:(UIButton*)btn {
    if (btn.tag == 0) {//返回
        [_webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1) {//评论
        self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        XYNCEditViewController * vc = [[XYNCEditViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.news = self.news;
        [self presentViewController:nav animated:NO completion:nil];
    }else if (btn.tag == 2) {//分享

        NSArray * arr = [self.sqlManager selectTableName:TABLE_NewsType parameters:@[@"*"] where:[NSString stringWithFormat:@"idString=\"%@\"",self.news.column_id]];
        NSString * text = @"#证券日报";
        NSInteger length = text.length;
        NSString * name = ((MDNewsType*)[arr firstObject]).name;
        if (name) {
            text = [text stringByAppendingFormat:@"#%@",name];
            length+=(name.length+1);
        }
        if (_news.detail_url) {
            length+=_news.detail_url.length;
            length+=@"手机访问:".length;
        }
        
        NSString * imageUrl = nil;
        NSString * title = @"";
        if (_news.shot_title) {
            title = _news.shot_title;
        }else if (_news.title) {
            title = _news.title;
        }
        if ([_news isKindOfClass:[MDNews class]]) {
            MDNews * n = (MDNews*)_news;
            if ([title isEqualToString:@""] && n.content_summary) {
                title = n.content_summary;
            }
            imageUrl = n.title_img;
        }
        if (title.length>0) {
            length+=2;
        }
        NSInteger rangeL = 140-length>0?140-length:0;
        title = [title substringWithRange:NSMakeRange(0, title.length<rangeL?title.length:rangeL)];
        XYShareViewController * vc = [[XYShareViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.text = [NSString stringWithFormat:@"#证券日报#%@#%@,手机访问:%@",name,title,_news.detail_url];
        vc.title = title;
        vc.url = _news.detail_url;
        vc.descriptionString = @"证券日报";
        vc.imageUrl = imageUrl;
        vc.mediaType = SSPublishContentMediaTypeNews;
        [self presentViewController:nav animated:NO completion:nil];
        
        
    }
    else {//收藏
        
        if (_isCollect) {
            if ([[XYSqlManager defaultService] deleteFromTableName:TABLE_MyCollect where:[NSString stringWithFormat:@"type=\"News\" and column_id=\"%@\" and idString=\"%@\"",_news.column_id,_news.idString]]) {
                _isCollect = NO;
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功" duration:1];
                [btn setImage:[UIImage imageNamed:@"news_tool41"] forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showErrorWithStatus:@"取消收藏失败" duration:1];
            }
            
        }
        else {
            MDCollect * collect = [[MDCollect alloc] initWithItem:_news];
            collect.comment_count = _comment_count;
            NSDateFormatter * fm = [[NSDateFormatter alloc] init];
            fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            collect.create_date = [fm stringFromDate:[NSDate date]];
            if ([[XYSqlManager defaultService] insertItem:collect]) {
                _isCollect = YES;
                [btn setImage:[UIImage imageNamed:@"news_tool42"] forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"收藏成功" duration:1];
            }else {
                NSLog(@"%@",[self.sqlManager.dataBase lastError]);
                [SVProgressHUD showErrorWithStatus:@"收藏失败" duration:1];
            }
        }
    }
}

///点击跟帖
- (void)clickNewsComment:(UITapGestureRecognizer*)gr {
    XYNewsCommentViewController * vc = [[XYNewsCommentViewController alloc] init];
    vc.news = self.news;
    vc.commentCountLabel = _commentCountLabel;
    if (_comment_count!=nil) {
//        NSLog(@"%d",[_comment_count integerValue]);
        vc.pageCount = ([_comment_count intValue]+14)/15;
    }
    [self.navigationController pushViewController:vc animated:YES];
}







#pragma mark - 解析
//获取新闻详情
- (void)getNewsDetail {
    NSString * adWidth = [NSString stringWithFormat:@"%.f",H_WIDTH];
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.2",@"mode",
                                 self.news.idString,@"id",
//                                 @"861",@"img_width",
                                 self.news.column_id,@"column_id",
                                 @"2",@"company_id",
                                 adWidth,@"ad_img_width",nil];
    [self RefreshAddAnimation];
    
    
    
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        GDataXMLElement * newsElement = [[root elementsForName:@"news"] firstObject];
        NSString * detail_url = [[[newsElement elementsForName:@"detail_url"] firstObject] stringValue];

        [_webView stopLoading];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detail_url?detail_url:self.news.detail_url]]];
    
        
        //获取广告
        _advertisement = [[MDAdvertisement alloc] initWithElement:newsElement];
        [self showOrHideAdvertisement:_advertisement];
        
        
        //跟帖
        _comment_count = [[[newsElement elementsForName:@"comment_count"] firstObject] stringValue];
        NSLog(@"跟帖%@",_comment_count);
        if (_comment_count!=nil) {
            _commentCountLabel.hidden = NO;
            _commentCountLabel.text = [NSString stringWithFormat:@"%@跟帖",_comment_count];
            CGSize size = [_commentCountLabel.text sizeWithFont:_commentCountLabel.font constrainedToSize:CGSizeMake(1000, 30)];
            _commentCountLabel.frame = CGRectMake(H_WIDTH-45-size.width, self.xToolBar.bounds.size.height-size.height-15, size.width+5, size.height+5);
        }
        
        
    } falid:^(NSString *errorMsg) {
        _commentCountLabel.hidden = YES;
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力哦，获取跟帖条数失败！" duration:1.5f];
    }];
}






#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIButton * button = [self.xNavigationBar.items objectAtIndex:2];
    [button.layer removeAnimationForKey:@"animate"];
    [webView addTouchesJavaScript];
    [self xxx];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
        UIButton * button = [self.xNavigationBar.items objectAtIndex:2];
        [button.layer removeAnimationForKey:@"animate"];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败" duration:1];
}

- (BOOL)webView:(UIWebView*)aWebView
shouldStartLoadWithRequest:(NSURLRequest*)aRequest
 navigationType:(UIWebViewNavigationType)aNavigationType {

    NSString *requestString = [[aRequest URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 2
		&& [(NSString *)[components objectAtIndex:0] isEqualToString:@"thweb"]
		&& [(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
	{
        NSString *eventString=[components objectAtIndex:2];
		if ([eventString isEqualToString:@"end"]) {
            //点击结束
            _clickCount++;
            [self performSelector:@selector(resetClickCount) withObject:nil afterDelay:0.3];
            if (_clickCount == 2) {
                if (self.editManager.screen == YES) {
                    NSLog(@"双击");
                    [self showOrHidenToolBarOnShow:self.xToolBar.hidden];
                }
            }
		}
        return NO;
    }
    return YES;
}


#pragma mark - 重置双击时间
- (void)resetClickCount {
    _clickCount = 0;
}

#pragma mark - 隐藏/显示广告
- (void)showOrHideAdvertisement:(MDAdvertisement*)adv {
    if (adv.ad_img!=nil && adv.ad_img_url!=nil) {//如果存在广告
        _adView.hidden = NO;
        [_adView setImageWithURL:[NSURL URLWithString:adv.ad_img] placeholderImage:[UIImage imageNamed:@"normal_advertisement"]];
        self.xToolBar.frame = CGRectMake(0, H_HEIGHT-AD_HEIGHT-TOOLBAR_HEIGHT, H_WIDTH, TOOLBAR_HEIGHT);
        self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-AD_HEIGHT-TOOLBAR_HEIGHT);
        
        //
        _webView.frame = self.xView.bounds;
    }
    else {
        _adView.hidden = YES;
        self.xToolBar.frame = CGRectMake(0, H_HEIGHT-TOOLBAR_HEIGHT, H_WIDTH, TOOLBAR_HEIGHT);
        self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-TOOLBAR_HEIGHT);
        _webView.frame = self.xView.bounds;
        
    }

}


#pragma mark - 全屏/非全屏
- (void)showOrHidenToolBarOnShow:(BOOL)show {
    
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame1 = self.xNavigationBar.frame;
        CGRect frame2 = self.xToolBar.frame;
        if (show) {//显示
            self.xToolBar.hidden = NO;
            self.xNavigationBar.hidden = NO;
            [self showOrHideAdvertisement:_advertisement];
            frame1.origin.y = 0;
            
            
            [self showOrHideAdvertisement:_advertisement];
            float adHeight = _adView.hidden?0:AD_HEIGHT;
            frame2.origin.y = H_HEIGHT-TOOLBAR_HEIGHT-adHeight;
            
            self.xNavigationBar.frame = frame1;
            self.xToolBar.frame = frame2;
            self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT, H_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT-TOOLBAR_HEIGHT-adHeight);
            _webView.frame = self.xView.bounds;
        }else {//隐藏
            frame1.origin.y = -NAVIGATION_HEIGHT;
            frame2.origin.y = H_HEIGHT;
            [self showOrHideAdvertisement:nil];
            
            
            self.xNavigationBar.frame = frame1;
            self.xToolBar.frame = frame2;
            self.xView.frame = CGRectMake(0, 0, H_WIDTH, H_HEIGHT);
            _webView.frame = self.xView.bounds;
        }
        
        
        
        
    } completion:^(BOOL finished) {
        if (show) {//~~
            
        }else {
            self.xNavigationBar.hidden = YES;
            self.xToolBar.hidden = YES;
        }
        
    }];
}
/*- (void)aaa:(MDNewsDetail*)newsDetail {
    [self.dataArray removeAllObjects];
    
    NSMutableDictionary * titleDic = [NSMutableDictionary dictionary];
    float y = NEWSDETAIL_GAP_V;
    
    if (newsDetail.title) {
        UIFont * font = NEWSDETAIL_TITLE_FONT;
        CGSize size = [newsDetail.title sizeWithFont:font constrainedToSize:CGSizeMake(NEWSDETAIL_WIDTH, 300)];
        [titleDic setObject:[NSNumber numberWithFloat:size.height] forKey:@"h1"];
        y+=size.height;
    }
    
    if (newsDetail.channels) {
        [titleDic setObject:[NSNumber numberWithFloat:30] forKey:@"h2"];
        y+=30;
    }
    
    if (newsDetail.images) {
        [titleDic setObject:[NSNumber numberWithFloat:NEWSDETAIL_IMG_HEIGHT] forKey:@"h3"];
        y+=NEWSDETAIL_IMG_HEIGHT;
    }
    
    if (newsDetail.content) {

        float height = NEWSDETAIL_HEIGHT-y;

        NSMutableArray * duans = [NSMutableArray arrayWithArray:[_newsDetail.content componentsSeparatedByString:@"\n"]];
        for (int i=0; i<duans.count; i++) {
            NSString * tmp = [duans objectAtIndex:i];
            if (tmp.length > 0 && tmp!= nil && ![tmp isEqualToString:@""]) {
                tmp = [NSString stringWithFormat:@"        %@",tmp];
                [duans replaceObjectAtIndex:i withObject:tmp];
            }
            
        }
        NSString * text = [duans componentsJoinedByString:@"\n"];
        NSRange range = [UILabel rangeToFitWithSize:CGSizeMake(NEWSDETAIL_WIDTH, height)
                               text:text
                               font:[UIFont systemFontOfSize:self.editManager.fontSize]];
        [titleDic setObject:[text substringWithRange:range] forKey:@"text1"];
        
        text = [text substringWithRange:NSMakeRange(range.length, text.length-range.length)];
        
        NSRange range2 = [UILabel rangeToFitWithSize:CGSizeMake(NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-NEWSDETAIL_GAP_V)
                                               text:text
                                               font:[UIFont systemFontOfSize:self.editManager.fontSize]];
        [titleDic setObject:[text substringWithRange:range2] forKey:@"text2"];
        
        
        [self.dataArray addObject:titleDic];
 
        text = [text substringWithRange:NSMakeRange(range2.length, text.length-range2.length)];
        while (1) {
            NSMutableDictionary * contentDic = [NSMutableDictionary dictionary];
            
            NSRange r1 = [UILabel rangeToFitWithSize:CGSizeMake(NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-NEWSDETAIL_GAP_V)
                                                   text:text
                                                   font:[UIFont systemFontOfSize:self.editManager.fontSize]];
            [contentDic setObject:[text substringWithRange:r1] forKey:@"text1"];
            
            if (r1.length >= text.length) {
                break;
            }
            
            text = [text substringWithRange:NSMakeRange(r1.length, text.length-r1.length)];
            
            NSRange r2 = [UILabel rangeToFitWithSize:CGSizeMake(NEWSDETAIL_WIDTH, NEWSDETAIL_HEIGHT-NEWSDETAIL_GAP_V)
                                                    text:text
                                                    font:[UIFont systemFontOfSize:self.editManager.fontSize]];
            [contentDic setObject:[text substringWithRange:r2] forKey:@"text2"];
            [self.dataArray addObject:contentDic];
            
            if (r2.length >= text.length) {
                break;
            }
            
            text = [text substringWithRange:NSMakeRange(r2.length, text.length-r2.length)];
        }
        
        [self RefreshCloseAnimation];
        [self.tableView reloadData];
    }
}*/


/*
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%@",self.dataArray);
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return H_WIDTH;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        XYNewsDetailHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
        if (cell == nil) {
            cell = [[XYNewsDetailHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head"];
        }
        cell.newsDetail = _newsDetail;
        NSDictionary * dic = [self.dataArray objectAtIndex:indexPath.row];
        cell.h1 = [[dic objectForKey:@"h1"] floatValue];
        cell.h2 = [[dic objectForKey:@"h2"] floatValue];
        cell.h3 = [[dic objectForKey:@"h3"] floatValue];
        cell.leftLabel.text = [dic objectForKey:@"text1"];
        cell.rightLabel.text = [dic objectForKey:@"text2"];
        return cell;
    }else {
        XYNewsDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
        if (cell == nil) {
            cell = [[XYNewsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"content"];
        }
        NSDictionary * dic = [self.dataArray objectAtIndex:indexPath.row];
        cell.leftLabel.text = [dic objectForKey:@"text1"];
        cell.rightLabel.text = [dic objectForKey:@"text2"];
        if (indexPath.row == self.dataArray.count-1) {
            [cell.rightLabel sizeToFit];
        }
        return cell;
    }
}*/
@end
