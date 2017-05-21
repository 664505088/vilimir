//
//  XYPageIndexControl.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-26.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPageIndexControl.h"

@implementation XYPageIndexControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float width = frame.size.width/2;
        //显示页码
        self.indexLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 5, width, 20)
                                                     Text:@"1"
                                                    Color:[UIColor whiteColor]
                                                     Font:13 textAlignment:1];
        _indexLabel.backgroundColor = [UIColor redColor];
        _indexLabel.layer.cornerRadius = 10;
        _indexLabel.clipsToBounds = YES;
        [self addSubview:_indexLabel];
        
        
        CGRect frame = _indexLabel.frame;
        CGSize size = [_indexLabel.text sizeWithFont:_indexLabel.font constrainedToSize:CGSizeMake(500, 20)];
        frame.origin.x = width-size.width-20;
        frame.size.width = 14+size.width;
        _indexLabel.frame = frame;
        
        
        //显示总页码的label
        self.countLabel = [XYFactory createLabelWithFrame:CGRectMake(width+10, 5, width, 20)
                                                   Text:@"/ 1"
                                                  Color:[UIColor grayColor]
                                                   Font:16 textAlignment:0];
        [self addSubview:_countLabel];

    }
    return self;
}

- (void)setindex:(int)index Count:(int)count {
    self.index = index;
    self.count = count;
}

- (void)setIndex:(int)index {
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%d",_index];
    CGRect frame = _indexLabel.frame;
    CGSize size = [_indexLabel.text sizeWithFont:_indexLabel.font constrainedToSize:CGSizeMake(500, 20)];
    frame.origin.x = self.bounds.size.width/2-size.width-10;
    frame.size.width = 13+size.width;
    _indexLabel.frame = frame;
}

- (void)setCount:(int)count {
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"/ %d",_count];
}
@end
