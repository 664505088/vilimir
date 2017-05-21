//
//  XYEpaperCalendarCell.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperCalendarCell.h"

@implementation XYEpaperCalendarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i=0; i<7; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:button];
            button.tag = i+100;
            button.layer.borderWidth = 0.5f;
            button.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.8].CGColor;
            [button addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UILabel * label = [[UILabel alloc] init];
            [button addSubview:label];
            label.tag = 1000;
        }
    }
    return self;
}

- (void)setDays:(NSArray *)days {
    _days = days;
    
    if (_days) {
        for (int i=0; i<7; i++) {
            UIButton * button = (UIButton*)[self.contentView viewWithTag:i+100];
            NSString * str = [days objectAtIndex:i];
            UILabel * label = (UILabel*)[button viewWithTag:1000];
            if (![str isEqualToString:@"null"]) {
                NSArray * arr = [str componentsSeparatedByString:@"/"];
                
                
                label.textAlignment = 1;
                label.text = [arr objectAtIndex:2];
                if ([[arr objectAtIndex:3] isEqualToString:@"1"]) {
                    button.backgroundColor = [UIColor grayColor];
                }else {
                    button.backgroundColor = [UIColor clearColor];
                }
                //            [button setTitle:str forState:UIControlStateNormal];
                NSDateFormatter * f = [[NSDateFormatter alloc] init];
                f.dateFormat = @"yyyy";
                int year = [[f stringFromDate:[NSDate date]] intValue];
                f.dateFormat = @"MM";
                int month = [[f stringFromDate:[NSDate date]] intValue];
                f.dateFormat = @"dd";
                int day = [[f stringFromDate:[NSDate date]] intValue];
                if ([[arr objectAtIndex:0] intValue]==year&& [[arr objectAtIndex:1] intValue] == month && [[arr objectAtIndex:2] intValue]==day ) {
//                    label.
                    label.backgroundColor = [UIColor redColor];
                    label.textColor = [UIColor whiteColor];
                }else {
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor blackColor];
                }
            }else {
                label.text = @"";
                button.backgroundColor = [UIColor clearColor];
                label.backgroundColor = [UIColor clearColor];
            }
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    for (int i=0; i<7; i++) {
        UIButton * button = (UIButton*)[self.contentView viewWithTag:i+100];
        button.frame = CGRectMake(i*width/7, 0, width/7, height);
        UILabel * label = (UILabel*)[button viewWithTag:1000];
        float w = MIN(width/7, height);
        w-=20;
        label.frame = CGRectMake((width/7-w)/2, (height-w)/2, w, w);
        label.layer.cornerRadius = w/2;
        label.clipsToBounds = YES;
    }
}

- (void)clickWithButton:(UIButton*)btn {
    if ([self.delegate respondsToSelector:@selector(epaperSelectedIndexPath:)]) {
        [self.delegate epaperSelectedIndexPath:[NSIndexPath indexPathForRow:row inSection:btn.tag-100]];
    }
}

- (void)setDays:(NSArray *)days delegate:(id<XYEpaperCalendarDelegate>)delegate indexPath:(NSIndexPath *)indexPath {
    self.days = days;
    self.delegate = delegate;
    row = indexPath.row;
}
@end
