//
//  XYEpaperViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-25.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperViewController.h"



@implementation XYEpaperViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.xNavigationBar.items objectAtIndex:2] addTarget:self action:@selector(clickNavigationRefreshButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.xView.frame = CGRectMake(MENU_WIDTH, NAVIGATION_HEIGHT, H_WIDTH-MENU_WIDTH, H_HEIGHT-NAVIGATION_HEIGHT);
    self.xToolBar.hidden = YES;

    //广告视图
    //创建广告
    _adView = [XYFactory createImageViewWithFrame:CGRectMake(41, self.xView.bounds.size.height-AD_HEIGHT, 840, AD_HEIGHT) Image:@"normal_advertisement"];
    _adView.backgroundColor = COLOR_RGB(170, 170, 170);
    [self.xView addSubview:_adView];
    UITapGestureRecognizer * adGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdView:)];
    _adView.userInteractionEnabled = YES;
    [_adView addGestureRecognizer:adGesture];
    _adView.hidden = YES;

    
    //广告页面关闭按钮
    UIButton * closeAdViewBtn = [XYFactory createButtonWithFrame:CGRectMake(_adView.frame.size.width-23, 0.5f, 23, 23) Image:@"icon_advertisem_close_1" Image:@"icon_advertisem_close_2"];
    [_adView addSubview:closeAdViewBtn];
    [closeAdViewBtn addTarget:self action:@selector(clickAdViewCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    closeAdViewBtn.backgroundColor = [UIColor whiteColor];
    
    
    CGRect frame = self.xView.bounds;
    frame.size.height = self.xView.bounds.size.height-AD_HEIGHT-65;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    

    
    
    _navigationButton = [XYFactory createButtonWithFrame:CGRectMake(60, self.xView.bounds.size.height-55-AD_HEIGHT, 124, 37) Image:@"button_epaper1" Image:@"button_epaper2"];
    [self.xView addSubview:_navigationButton];
    
    [_navigationButton addSubview:[XYFactory createLabelWithFrame:_navigationButton.bounds Text:@"版面导航" Color:[UIColor whiteColor] Font:20 textAlignment:1]];
    
    _historyButton = [XYFactory createButtonWithFrame:CGRectMake(250, self.xView.bounds.size.height-55-AD_HEIGHT, 124, 37) Image:@"button_epaper1" Image:@"button_epaper2"];
    [self.xView addSubview:_historyButton];
    
    [_historyButton addSubview:[XYFactory createLabelWithFrame:_historyButton.bounds Text:@"查看往期" Color:[UIColor whiteColor] Font:20 textAlignment:1]];
    
    
    UIButton * dateButton = [XYFactory createButtonWithFrame:CGRectMake(45+MENU_WIDTH, 25+STATUS_HEIGHT, 45, 45) Image:@"button_epaper_date1" Image:@"button_epaper_date2"];
    [self.xNavigationBar addSubview:dateButton];
    
    
    
    dateButton.tag = 0;
    _navigationButton.tag = 1;
    _historyButton.tag = 2;
    
    [dateButton addTarget:self action:@selector(clickLeftViewButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationButton addTarget:self action:@selector(clickLeftViewButton:) forControlEvents:UIControlEventTouchUpInside];
    [_historyButton addTarget:self action:@selector(clickLeftViewButton:) forControlEvents:UIControlEventTouchUpInside];
    _dateLabel = [XYFactory createLabelWithFrame:CGRectMake(45+MENU_WIDTH+50, 35+STATUS_HEIGHT, 150, 30) Text:nil];
    [self.xNavigationBar addSubview:_dateLabel];
    
    //首次加载今日(当天没有电子报,一直加载到之前有电子报的那一天,no,只显示当天)
    _isFirst = YES;
    //默认点击今日
    NSDate * date = [NSDate date];
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy";
    self.year = [f stringFromDate:date];
    f.dateFormat = @"MM";
    self.month = [f stringFromDate:date];
    f.dateFormat = @"dd";
    self.day = [f stringFromDate:date];
    //今天-a1
    [self getEpaperList];
}


#pragma mark - 点击
///点击刷新
- (void)clickNavigationRefreshButton:(UIButton *)btn {
    _isFirst = NO;
    [self getEpaperList];
}
///点击广告
- (void)clickAdView:(UITapGestureRecognizer*)gr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_advertisement.ad_img_url]];
//    XYAdvertisementViewController * vc = [[XYAdvertisementViewController alloc] init];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    vc.url = _advertisement.ad_img_url;
//    [self.navigationController pushViewController:vc animated:YES];
}
//关闭广告
- (void)clickAdViewCloseButton:(UIButton*)btn {
    [self getAdvertisement:nil];
}

//点击今日,版面导航,查看往期
- (void)clickLeftViewButton:(UIButton*)btn {
    //今日
    if (btn.tag == 0) {
        _isFirst = NO;
        NSDate * date = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"yyyy";
        self.year = [f stringFromDate:date];
        f.dateFormat = @"MM";
        self.month = [f stringFromDate:date];
        f.dateFormat = @"dd";
        self.day = [f stringFromDate:date];
        //今天-a1
        [self getEpaperList];
    }
    //版面导航
    else if (btn.tag == 1) {
        XYEpaperNavigationViewController * vc = [[XYEpaperNavigationViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.delegate = self;
        vc.dataArray = self.dataArray;
        [self presentViewController:nav animated:NO completion:nil];
    }
    //查看往期
    else if (btn.tag == 2) {
        XYEpaperCalendarViewController * vc = [[XYEpaperCalendarViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.delegate = self;
        [self presentViewController:nav animated:NO completion:nil];
    }
}


#pragma mark - 解析
///刷新
- (void)getEpaperList {
    [self getAdvertisement:_advertisement];
    if (self.netStatus) {
        [self getNetEpaper];
    }else {
        [self getSqlEpaperWithYear:self.year month:self.month day:self.day msg:REQUEST_MESSAGE_FAIL];
    }
}

- (void)getNetEpaper {
    NSString * date = [NSString stringWithFormat:@"%@-%@-%@",_year,_month,_day];
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          date,@"month",
                          @"pad_2.3",@"mode", nil];
    [self RefreshAddAnimation];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * arr = [[[root elementsForName:@"code_list"] firstObject] elementsForName:@"code_ele"];
        
        

        
        if (arr.count>0) {
            [self.sqlManager deleteFromTableName:TABLE_Epaper where:[NSString stringWithFormat:@"year=\"%@\" and month=\"%@\" and day=\"%@\"",self.year,self.month,self.day]];
        }
        if ([self.day isEqualToString:@"22"]) {
            
        }
        NSLog(@"今天个数=%d",arr.count);
        if (arr.count>0) {
            for (GDataXMLElement * element in arr) {
                MDEpaper * epaper = [[MDEpaper alloc] initWithElement:element];
                epaper.year = self.year;
                epaper.month = self.month;
                epaper.day = self.day;
                if (![self.sqlManager insertItem:epaper]) {
                    NSLog(@"数据库插入失败 %@",[self.sqlManager.dataBase lastError]);
                }
            }
        }


        //获取广告
        _advertisement = [[MDAdvertisement alloc] initWithElement:nil];
        //显示or隐藏广告
//        _advertisement.ad_img = @"aa";
//        _advertisement.ad_img_url = @"http://www.baidu.com";
        [self getAdvertisement:_advertisement];
        
        
        
        [self getSqlEpaperWithYear:self.year
                             month:self.month
                               day:self.day
                               msg:nil];
        
    } falid:^(NSString *errorMsg) {
        [self getSqlEpaperWithYear:self.year
                             month:self.month
                               day:self.day
                               msg:errorMsg];
    }];
  
}

- (void)getSqlEpaperWithYear:(NSString*)year
                       month:(NSString*)month
                         day:(NSString*)day
                         msg:(NSString*)msg{
    NSString * where = [NSString stringWithFormat:@"year=\"%@\" and month=\"%@\" and day=\"%@\" ",year,month,day];
    NSArray * arr = [self.sqlManager selectTableName:TABLE_Epaper parameters:@[@"*"] where:where];
    [self.dataArray removeAllObjects];
    if (arr.count>0) {
        [self.dataArray addObjectsFromArray:arr];
        if (msg) {
            [SVProgressHUD dismissWithError:msg];
        }else {
            [SVProgressHUD dismiss];
        }
    }else {
        if (_isFirst) {
            int year = [self.year intValue];
            int month = [self.month intValue];
            int day = [self.day intValue];
            day--;
            if (day<=0) {
                month--;
                if (month<=0) {
                    year--;
                }
            }
            if (month<=0) {
                month = 12;
            }
            
            if (year<2013) {
                [SVProgressHUD dismissWithError:@"没有2013年以前的电子报"];
                NSLog(@"没有2013年以前的电子报");
                return;
            }
            else {
                if (month==0) {
                    month = 12;
                }
                if (day == 0) {
                    day = [self GetNumberOfDayByYera:year andByMonth:month];
                }
                self.year = [NSString stringWithFormat:@"%d",year];
                self.month = month < 10?[NSString stringWithFormat:@"0%d",month]:[NSString stringWithFormat:@"%d",month];
                self.day = day < 10?[NSString stringWithFormat:@"0%d",day]:[NSString stringWithFormat:@"%d",day];
                
                if (self.netStatus) {
                    [self getNetEpaper];
                }else {
                    [self getSqlEpaperWithYear:self.year month:self.month day:self.day msg:REQUEST_MESSAGE_NONE];
                }
            }
        }
        else {
            if (msg) {
                [SVProgressHUD dismissWithError:msg];
            }else {
                [SVProgressHUD dismissWithError:[NSString stringWithFormat:@"没有%@-%@-%@的电子报",self.year,self.month,self.day]];
                NSLog(@"没有%@-%@-%@的电子报",self.year,self.month,self.day);
            }
        }
    }
 
    [self RefreshCloseAnimation];
    [self.tableView reloadData];
    _dateLabel.text = [NSString stringWithFormat:@"%@-%@-%@",self.year,self.month,self.day];
}

- (void)getAdvertisement:(MDAdvertisement*)adv {
    if (adv != nil && adv.ad_img!=nil && adv.ad_img_url!=nil) {//如果存在广告
        _adView.hidden = NO;
        CGRect frame = self.tableView.frame;
        frame.origin.y = 0;
        self.tableView.frame = frame;
        frame = _navigationButton.frame;
        frame.origin.y = self.xView.bounds.size.height-55-AD_HEIGHT;
        _navigationButton.frame = frame;
        frame = _historyButton.frame;
        frame.origin.y = self.xView.bounds.size.height-55-AD_HEIGHT;
        _historyButton.frame = frame;
    }else {
        _adView.hidden = YES;
        CGRect frame = self.tableView.frame;
        frame.origin.y = AD_HEIGHT/2;
        self.tableView.frame = frame;
        frame = _navigationButton.frame;
        frame.origin.y = self.xView.bounds.size.height-55;
        _navigationButton.frame = frame;
        frame = _historyButton.frame;
        frame.origin.y = self.xView.bounds.size.height-55;
        _historyButton.frame = frame;
    }
}
#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return LEFT_FRAME.size.width;
    return self.xView.bounds.size.width/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYEpaperLayoutCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYEpaperLayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    MDEpaper * epaper = [self.dataArray objectAtIndex:indexPath.row];
    NSString * url = [[epaper.img componentsSeparatedByString:@"../../../"] componentsJoinedByString:@""];
    [cell.imgView setImageWithURL:[NSURL URLWithString:url]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYEpaperDetailViewController * vc = [[XYEpaperDetailViewController alloc] init];
    vc.epaper = [self.dataArray objectAtIndex:indexPath.row];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}






#pragma mark - 返回代理
- (void)epaperDateWithIndex:(NSInteger)index {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void)epaperDateWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    self.year = year;
    self.month = month;
    self.day = day;
    _isFirst = NO;
    [self clickNavigationRefreshButton:nil];
}


//判断year年month月有多少天
-(int)GetNumberOfDayByYera:(int)year
                andByMonth:(int)month{
    int nummonth = 0;
    //判断month月有多少天
    if ((month == 1)|| (month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        nummonth = 31;
    else if ((month == 4)|| (month == 6)||(month == 9)||(month == 11))
        nummonth = 30;
    else if (((year/4==0&&year/100!=0)||(year/400==0))&&(month>2))
        nummonth = 29;
    else nummonth = 28;
    return nummonth;
}
@end

