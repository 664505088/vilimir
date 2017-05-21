//
//  XYCollectTypeView.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYCollectTypeView.h"

@implementation XYCollectTypeView



- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        float width = frame.size.width;
        float height = frame.size.height;
        self.buttons = [[NSMutableArray alloc] init];
        if (titles.count >0) {
            float w = width/titles.count;
            
            for (int i=0; i<titles.count; i++) {
                UIButton * button = [XYFactory createButtonWithFrame:CGRectMake(i*w, 0, w, height) Title:nil buttonWithType:UIButtonTypeCustom];
                button.tag = i;
                [self addSubview:button];
                [self.buttons addObject:button];

                
                UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(0, 0, w, height-5) Text:titles[i] Color:nil Font:height/2 textAlignment:1];
                label.tag = LABEL_TAG;
                [button addSubview:label];
                
                [button addTarget:self action:@selector(clickSelectCollectTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
            }
  
            self.redView = [XYFactory createImageViewWithFrame:CGRectMake(0, height-5, w, 5) Image:nil];
            _redView.backgroundColor = [UIColor redColor];
            [self addSubview:_redView];
        }
   
        
    }
    return self;
}
//x x x   xxx
- (void)setGap:(float)gap {
    _gap = gap;
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    NSInteger count = self.buttons.count;
    float w = (width-(count-1)*gap)/count;
    for (int i=0; i<self.buttons.count; i++) {
        UIButton * tmp = [_buttons objectAtIndex:i];
        tmp.frame = CGRectMake(i*(w+gap), 0, w, height);
        UILabel * label = (UILabel*)[tmp viewWithTag:LABEL_TAG];
        label.frame = tmp.bounds;
    }
    _redView.frame = CGRectMake(_selectedIndex*(w+_gap), height-5, w, 5);
}
- (void)clickSelectCollectTypeWithButton:(UIButton*)btn {
    
    for (int i=0; i<self.buttons.count; i++) {
        UIButton * tmp = [_buttons objectAtIndex:i];
        UILabel * label = (UILabel*)[tmp viewWithTag:LABEL_TAG];
        if (btn == tmp) {
            self.selectedIndex = i;
            label.textColor = [UIColor blackColor];
        }
        else {
            label.textColor = [UIColor grayColor];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        float width = self.bounds.size.width;
        float height = self.bounds.size.height;
        NSInteger count = self.buttons.count;
        float w = (width-(count-1)*_gap)/count;
        _redView.frame = CGRectMake(_selectedIndex*(w+_gap), height-5, w, 5);

    }];
    
    if (_target && _action) {
        [_target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
    
}

- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
}
@end
