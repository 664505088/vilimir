//
//  XYSelectView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-5.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYSelectView.h"

@implementation XYSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float height = frame.size.height;
        float width = frame.size.width;
        self.titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 0, width-height, height) Text:nil Color:nil Font:-1 textAlignment:1];
        [self addSubview:_titleLabel];
        
        self.button = [XYFactory createButtonWithFrame:self.bounds Image:nil];
        [self addSubview:_button];
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * v = [XYFactory createImageViewWithFrame:CGRectMake(width-height, 0, height, height) Image:nil];
        [self addSubview:v];
        
        UIGraphicsBeginImageContext(v.frame.size);
        [v.image drawInRect:v.bounds];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        
        //画条竖线
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 136./255, 199./255, 201./255, 1.0);//线条颜色
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0,0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, height);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        //画三角形
        float gap = (height-height/4)/2;
        CGPoint sPoints[3];//坐标点
        sPoints[0] =CGPointMake(height/3, gap);//坐标1
        sPoints[1] =CGPointMake(height/3*2, gap);//坐标2
        sPoints[2] =CGPointMake(height/2, height-gap);//坐标3
        CGContextAddLines(UIGraphicsGetCurrentContext(), sPoints, 3);//添加线
        CGContextClosePath(UIGraphicsGetCurrentContext());//封起来
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke); //根据坐标绘制路径
        
        v.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        

        

    }
    return self;
}

- (void)clickButton:(UIButton*)button {
    if (self.tableView == nil) {
        UIView * view = self.superview;
        float x = self.frame.origin.x;
        float y = self.frame.origin.y;
        self.tableView = [XYFactory createTableViewWithFrame:CGRectMake(x, y+self.frame.size.height, self.bounds.size.width, view.bounds.size.height/2) style:UITableViewStylePlain delegate:self];
        [view addSubview:_tableView];
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor grayColor].CGColor;
        [view bringSubviewToFront:_tableView];
        _tableView.hidden = YES;
    }
    _tableView.hidden = !_tableView.hidden;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.tableView.hidden = YES;
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)setIndex:(NSInteger)index {
    if (index < self.titleArray.count && index>=0) {
        if (_index != index) {
            _index = index;
            self.titleLabel.text = [self.titleArray objectAtIndex:_index];
        }
    }
}

@end
