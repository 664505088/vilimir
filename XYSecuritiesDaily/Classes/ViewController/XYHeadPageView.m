//
//  XYHeadPageView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYHeadPageView.h"

@implementation XYHeadPageView



- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        _tableView = [XYFactory createTableViewWithFrame:self.bounds horizontal:YES style:UITableViewStylePlain delegate:self];
        _tableView.pagingEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tableView];

        
        
        self.pageControl = [[XYPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 15)];
        [self addSubview:_pageControl];

        [self addObserver:self forKeyPath:@"dataSouth" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = self.bounds.size.width;
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _pageControl.count = (int)_dataSouth.count;
    _pageControl.index = 0;
    return self.dataSouth.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYHeadPageItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
    if (cell == nil) {
        cell = [[XYHeadPageItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];

    }
    MDHeadNews * headNews = [_dataSouth objectAtIndex:indexPath.row];
    if (headNews.shot_title && ![headNews.shot_title isEqualToString:@""]) {
        cell.titleLabel.text = headNews.shot_title;
    }else if (headNews.title && ![headNews.title isEqualToString:@""]){
        NSString * title = headNews.title;
        if (headNews.title.length>18) {
            title = [headNews.title substringToIndex:18];
        }
        cell.titleLabel.text = title;
    }else {
        cell.titleLabel.text = @"暂无标题";
    }
    if (headNews.head_img) {
        [cell.headImageView setImageWithURL:[NSURL URLWithString:headNews.head_img]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(headPageView:didSelectRowAtIndex:)]) {
        [self.delegate headPageView:self didSelectRowAtIndex:(int)indexPath.row];
    }
}


//滑动停止调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        float y = scrollView.contentOffset.y;
        float width = scrollView.bounds.size.height;
        _pageControl.index = (int)y/width;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float y = scrollView.contentOffset.y;
    float width = scrollView.bounds.size.height;
    int index = (int)(y/width);
    _pageControl.index = index;
}


//监听数据源
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [_tableView reloadData];
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(move)
                                   userInfo:nil repeats:YES];

}

- (void)move {
    //5   0 1 2 3 4
    int index = _pageControl.index;
    index++;
    if (index < self.dataSouth.count ) {
        _pageControl.index = index;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index
                                                            inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    else {
        _pageControl.index = 0;
        if (self.dataSouth.count >0) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    
}

@end
