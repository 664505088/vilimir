//
//  XYRefreshTableHeadView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-17.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYRefreshTableHeadView.h"

@implementation XYRefreshTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_RGB(231, 237, 255);
        
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, self.frame.size.height-35, self.frame.size.width, 25) Text:@"下拉开始刷新..." Color:COLOR_RGB(87, 108, 137) Font:-1 textAlignment:1];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        
        NSString * lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:kREFRESH_PHOTO_DETAIL_HEAD_LAST_DATE];
        self.subTitleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 20) Text:lastDate Color:COLOR_RGB(87, 108, 137) Font:-1 textAlignment:1];
        [self addSubview:_subTitleLabel];
        _subTitleLabel.font = [UIFont boldSystemFontOfSize:13];
        
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 20, 40, 40)];
        [self addSubview:_activity];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        [_activity startAnimating];
    }
    return self;
}

- (void)startWithScrollView:(UIScrollView*)scrollView {
    [_activity startAnimating];
    _activity.hidden = NO;
    
    _titleLabel.text = @"刷新中...";
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"最后一次刷新:yy-MM-dd HH:mm";
    NSString * lastDate = [df stringFromDate:[NSDate date]];
    _subTitleLabel.text = lastDate;
    [[NSUserDefaults standardUserDefaults] setObject:lastDate forKey:kREFRESH_PHOTO_DETAIL_HEAD_LAST_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)stopWithTitle:(NSString*)title {
    [_activity stopAnimating];
    _activity.hidden = YES;
    if (title) {
        _titleLabel.text = title;
    }
}

@end
