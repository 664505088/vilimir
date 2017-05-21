//
//  XYEpaperCalendarViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperCalendarViewController.h"


@implementation XYEpaperCalendarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xView.frame = CGRectMake((H_WIDTH-400)/2, (H_HEIGHT-400)/2, 400, 400);

    _dateArray = [[NSMutableArray alloc] init];
    
    _calendarView = [[XYEpaperCalendarView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_calendarView];
    _calendarView.tableView.delegate = self;
    _calendarView.tableView.dataSource = self;
    [_calendarView addTarget:self action:@selector(clickUpdate:)];
    [self getEpaper];
    
}



#pragma mark - 点击
//点击选择时间
- (void)clickUpdate:(XYEpaperCalendarView*)calendar {
    [self getEpaper];
}

- (void)getEpaper {
    NSLog(@"%d年%d月",_calendarView.year,_calendarView.month);
    [self DateWithYear:_calendarView.year month:_calendarView.month add:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.xView.bounds.size.height-115.0)/5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"%d",[[_dateArray objectAtIndex:section] count]);
    return _dateArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYEpaperCalendarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYEpaperCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];

    }
    NSArray * days = [_dateArray objectAtIndex:indexPath.row];
    [cell setDays:days delegate:self indexPath:indexPath];
    return cell;
}

- (void)epaperSelectedIndexPath:(NSIndexPath *)indexPath {
    NSString * dateStr = [[_dateArray objectAtIndex:indexPath.row] objectAtIndex:indexPath.section];
    if (![dateStr isEqualToString:@"null"]) {
        NSArray * arr = [dateStr componentsSeparatedByString:@"/"];
        int intYear = [arr[0] intValue];
        int intMonth = [arr[1] intValue];
        int intDay = [arr[2] intValue];
        NSString * year = [NSString stringWithFormat:@"%d",intYear];
        NSString * month = intMonth<10?[NSString stringWithFormat:@"0%d",intMonth]:[NSString stringWithFormat:@"%d",intMonth];
        NSString * day = intDay<10?[NSString stringWithFormat:@"0%d",intDay]:[NSString stringWithFormat:@"%d",intDay];

        if ([arr[3] isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"没有%@-%@-%@的电子报",year,month,day] duration:3.0f];
        }else {
            if ([self.delegate respondsToSelector:@selector(epaperDateWithYear:month:day:)]) {
                
                [self.delegate epaperDateWithYear:year month:month day:day];
            }
            [self clickBlackPoint];
        }
    }
    
    
}




#pragma mark - 计算
- (void)DateWithYear:(int)year month:(int)month add:(BOOL)add {
    NSDate * date = [NSDate date];
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy";
    int nYear = [[f stringFromDate:date] intValue];
    f.dateFormat = @"MM";
    int nMonth = [[f stringFromDate:date] intValue];
    f.dateFormat = @"dd";
    int nDay = [[f stringFromDate:date] intValue];

    
    
    NSString * yearStr = [NSString stringWithFormat:@"%d",year];
    NSString * monthStr;
    if (month<10) {
        monthStr = [NSString stringWithFormat:@"0%d",month];
    }else {
        monthStr = [NSString stringWithFormat:@"%d",month];
    }
    NSString * where = [NSString stringWithFormat:@"year=\"%@\" and month=\"%@\"",yearStr,monthStr];
    

    //如果是历史月份
    if (year < nYear || (year==nYear && month < nMonth)) {
        if ([self.sqlManager selectCountWithTableName:TABLE_EpaperCalendar where:where]>0) {
            [self getSqlWithYear:yearStr month:monthStr msg:nil];
        }
        else {
            if (self.netStatus) {
                [self getNetWithYear:yearStr month:monthStr];
            }else {
                [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1.5f];
            }
        }
    }
    //如果是今年 下个月
    else if (year == nYear && month > nMonth){
        [self getSqlWithYear:yearStr month:monthStr msg:@"超出今天日期"];
    }
    //如果是今年今月
    else if (year == nYear && month == nMonth) {
        //如果存在历史数据
        if ([self.sqlManager selectCountWithTableName:TABLE_EpaperCalendar where:where]>0) {
            
            MDEpaperCalendar * calendar = [[self.sqlManager selectTableName:TABLE_EpaperCalendar parameters:@[@"*"] where:where] lastObject];
            //查找最后一天出报时间
            NSString * oDay = calendar.day;
            //如果今天比最后一次出报时间大, 重新获取该月数据
            if (nDay > [oDay intValue] ) {
                if (self.netStatus) {
                    [self getNetWithYear:yearStr month:monthStr];
                }else {
                    [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1.5f];
                }
            }
            //否则加载历史数据
            else {
                [self getSqlWithYear:yearStr month:monthStr msg:nil];
            }
        }
        else {
            if (self.netStatus) {
                [self getNetWithYear:yearStr month:monthStr];
            }else {
                [SVProgressHUD showErrorWithStatus:REQUEST_MESSAGE_FAIL duration:1.5f];
            }
        }
    }
}

- (void)getNetWithYear:(NSString*)year month:(NSString*)month {
    
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@-%@",year,month],@"month",
                                 @"pad_2.2",@"mode",nil];

    [SVProgressHUD showWithStatus:@"刷新中..."];
    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * date_list = [[[root elementsForName:@"date_list"] firstObject] elementsForName:@"date"];

        if (date_list.count>0) {
            [self.sqlManager deleteFromTableName:TABLE_EpaperCalendar where:[NSString stringWithFormat:@"year = \"%@\" and month=\"%@\"",year,month]];
            for (int i=0; i<date_list.count; i++) {
                
                GDataXMLElement * element = [date_list objectAtIndex:i];

                MDEpaperCalendar * calendar = [[MDEpaperCalendar alloc] initWithElement:element];
                if (![self.sqlManager insertItem:calendar]) {
                    NSLog(@"插入日期数据失败 %@",[self.sqlManager.dataBase lastError]);
                }
            }
            
        }
        [self getSqlWithYear:year month:month msg:nil];
    } falid:^(NSString *errorMsg) {
        [SVProgressHUD dismissWithError:REQUEST_MESSAGE_FAIL];
    }];

}

- (void)getSqlWithYear:(NSString*)year month:(NSString*)month msg:(NSString*)msg {
    int dayCount = [self GetNumberOfDayByYera:[year intValue] andByMonth:[month intValue]];
    int week = [self GetTheWeekOfDayByYera:[year intValue] andByMonth:[month intValue]];
    NSString * where = [NSString stringWithFormat:@"year=\"%@\" and month=\"%@\"",year,month];
     NSArray * arr = [self.sqlManager selectTableName:TABLE_EpaperCalendar parameters:@[@"*"] where:where];
    [_dateArray removeAllObjects];

    int x = (dayCount+week)%7==0?(dayCount+week)/7:(dayCount+week)/7+1;
    int index = 1;
    int tmpIndex = 0;
    for (int i=0; i<x; i++) {
        NSMutableArray * days = [NSMutableArray array];
        for (int j=0; j<7; j++) {
            if (i==0) {
                if (j<week) {
                    [days addObject:@"null"];
                }else {
                    //1号~index号
                    BOOL ishas = NO;
                    for (int c=tmpIndex; c<arr.count; c++) {
                        MDEpaperCalendar * calendar = [arr objectAtIndex:c];
                        if (index==[calendar.day intValue]) {
                            [days addObject:[NSString stringWithFormat:@"%@/%@/%d/%@",year,month,index,@"1"]];
                            tmpIndex++;
                            ishas = YES;
                            break;
                        }
                    }
                    if (!ishas) {
                        [days addObject:[NSString stringWithFormat:@"%@/%@/%d/%@",year,month,index,@"0"]];
                    }
                    index++;
                }
            }
            else {
                
                if (index <= dayCount) {
                    BOOL ishas = NO;
                    for (int c=tmpIndex; c<arr.count; c++) {
                        MDEpaperCalendar * calendar = [arr objectAtIndex:c];
                        if (index==[calendar.day intValue]) {
                            [days addObject:[NSString stringWithFormat:@"%@/%@/%d/%@",year,month,index,@"1"]];
                            tmpIndex++;
                            ishas = YES;
                            break;
                        }
                    }
                    if (!ishas) {
                        [days addObject:[NSString stringWithFormat:@"%@/%@/%d/%@",year,month,index,@"0"]];
                    }
                    index++;
                }
                else {
                    [days addObject:@"null"];
                }
                
            }
        }
        [_dateArray addObject:days];
    }
    [_calendarView.tableView reloadData];
    
    if (arr.count > 0) {
        if (!msg) {
            [SVProgressHUD dismiss];
        }else {
            [SVProgressHUD dismissWithError:REQUEST_MESSAGE_CACHE];
        }
    }
    else {
        if (msg) {
            [SVProgressHUD dismissWithError:msg];
        }else {
            [SVProgressHUD dismissWithError:REQUEST_MESSAGE_NONE];
        }
    }
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


//计算year年month月第一天是星期几，周日则为0
-(int)GetTheWeekOfDayByYera:(int)year
                 andByMonth:(int)month{
    int numWeek = ((year-1)+ (year-1)/4-(year-1)/100+(year-1)/400+1)%7;//numWeek为years年的第一天是星期几
    //NSLog(@"%d",numWeek);
    int ar[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    int numdays = (((year/4==0&&year/100!=0)||(year/400==0))&&(month>2))?(ar[month-1]+1):(ar[month-1]);//numdays为month月years年的第一天是这一年的第几天
    //NSLog(@"%d",numdays);
    int dayweek = (numdays%7 + numWeek)%7;//month月第一天是星期几，周日则为0
    //NSLog(@"%d",dayweek);
    return dayweek;
}



#pragma mark - 其他
- (BOOL)netStatus {
    //    return NO;
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable;
    
}
@end
