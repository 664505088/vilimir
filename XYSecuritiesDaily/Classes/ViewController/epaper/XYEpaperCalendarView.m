//
//  XYEpaperCalendarView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperCalendarView.h"

@implementation XYEpaperCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        
        //时间选择视图背景
        UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.bounds Image:nil];
        UIImage * image = [UIImage imageNamed:@"info_bg1"];
        loginBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self addSubview:loginBg];
        float h = 45;
        //标题
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, (h-35)/2, frame.size.width, 35) Text:@"查看往期" Color:nil Font:24 textAlignment:1];
        [self addSubview:_titleLabel];
        
        
//        //确定按钮
//        self.confirmBtn = [XYFactory createButtonWithFrame:CGRectMake(15, (h-30)/2+0.5f, 89, 30) Image:@"info_button_forget1" Image:@"info_button_forget2"];
//        _confirmBtn.clipsToBounds = NO;
//        [self addSubview:_confirmBtn];
//        
//        [_confirmBtn addSubview:[XYFactory createLabelWithFrame:_confirmBtn.bounds Text:@"确定" Color:COLOR_RGB(146,154,155) Font:17 textAlignment:1]];
        

        NSDate * date = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"yyyy";
        int year = [[f stringFromDate:date] intValue];
        f.dateFormat = @"MM";
        int month = [[f stringFromDate:date] intValue];

        
        //选择年份
        _yearSelectView = [[XYSelectView alloc] initWithFrame:CGRectMake(10, h+5, 100, 30)];
        [self addSubview:_yearSelectView];
        _yearSelectView.delegate = self;
        NSMutableArray * yearArray = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            [yearArray addObject:[NSString stringWithFormat:@"%d年",year-(9-i)]];
        }
        _yearSelectView.titleArray = yearArray;
        _yearSelectView.index = 9;
        
        //选择月份
        _monthSelectView = [[XYSelectView alloc] initWithFrame:CGRectMake(180, h+5, 100, 30)];
        [self addSubview:_monthSelectView];
        _monthSelectView.delegate = self;
        _monthSelectView.titleArray = [NSArray arrayWithObjects:@"1月",
                             @"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",nil];
        _monthSelectView.index = month-1;
    
        
        
        //添加左右按钮
        UIButton * left = [XYFactory createButtonWithFrame:CGRectMake(150, h+5, 30, 30) Image:nil];
        [self addSubview:left];
        left.layer.borderWidth = 1;
        left.layer.borderColor = [UIColor grayColor].CGColor;
        float w = left.bounds.size.width;

        UIGraphicsBeginImageContext(left.frame.size);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 136./255, 199./255, 201./255, 1.0);//线条颜色
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), w/3*2,w/4);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), w/3, w/2);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), w/3*2,w/4*3);
        CGContextStrokePath(UIGraphicsGetCurrentContext());

        UIImage * leftImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [left setImage:leftImage forState:UIControlStateNormal];
        
        
 
        
        
        //添加左右按钮
        UIButton * right = [XYFactory createButtonWithFrame:CGRectMake(280, h+5, 30, 30) Image:nil];
        right.tag = 1;
        [self addSubview:right];
        right.layer.borderWidth = 1;
        right.layer.borderColor = [UIColor grayColor].CGColor;
        
        //制作图片
        UIGraphicsBeginImageContext(right.frame.size);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 136./255, 199./255, 201./255, 1.0);//线条颜色
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), w/3,w/4);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), w/3*2, w/2);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), w/3,w/4*3);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        UIImage *rightImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [right setImage:rightImage forState:UIControlStateNormal];
        [left addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [right addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //分割线
        UIImageView * line = [XYFactory createImageViewWithFrame:CGRectMake(10, h+40, frame.size.width-20, 1) Image:nil];
        [self addSubview:line];
        line.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        //显示周
        NSArray * weeks = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        for (int i=0; i<7; i++) {
            UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(i*frame.size.width/7, h+45, frame.size.width/7, 20) Text:weeks[i] Color:nil Font:15 textAlignment:1];
            [self addSubview:label];
        }
        
        self.year = year;
        self.month = month;
        
        ///显示日历(每天)
        self.tableView = [XYFactory createTableViewWithFrame:CGRectMake(0, h+70, frame.size.width, frame.size.height-70-h) style:UITableViewStylePlain delegate:nil];
        [self addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//        [self DateWithYear:year month:month add:YES];
        
    }
    return self;
}

- (void)clickButton:(UIButton*)btn {
    NSInteger monthIndex = _monthSelectView.index;
    NSInteger yearIndex = _yearSelectView.index;
    if (btn.tag == 1) {
        monthIndex++;
    }else {
        monthIndex--;
    }
    if (monthIndex == 12) {
        
        yearIndex++;
        if (yearIndex>=_yearSelectView.titleArray.count) {
            yearIndex = _yearSelectView.titleArray.count-1;
            monthIndex = 11;
        }else {
            monthIndex = 0;
        }
        
    }else if (monthIndex == -1) {
        
        yearIndex--;
        if (yearIndex<0) {
            yearIndex = 0;
            monthIndex = 0;
        }else {
            monthIndex = 11;
        }
    }
    //修改年,月控件的属性
    _monthSelectView.index = monthIndex;
    _yearSelectView.index = yearIndex;
    //传递代理
    [self tableView:nil didSelectRowAtIndexPath:nil];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int year = [[[[_yearSelectView.titleArray objectAtIndex:_yearSelectView.index] componentsSeparatedByString:@"年"] firstObject] intValue];
    int month = [[[[_monthSelectView.titleArray objectAtIndex:_monthSelectView.index] componentsSeparatedByString:@"月"] firstObject] intValue];
    self.year = year;
    self.month = month;
    if (_target && _action) {
        [_target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
}

- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
}

@end
