//
//  XYNewsPageCell.h
//  SecuritiesDaily
//  新闻列表cell (没条cell包含8个左右newItemView)
//  Created by xiwang on 14-5-22.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNewItemView.h"
#import "XYHeadPageView.h"
#import "XYNewsPageSelectedDelegate.h"

#define NEWSCELL_HEIGHT 580

@interface XYNewsPageCell : UITableViewCell

{
    NSMutableArray  * _lineHArray;
    NSMutableArray  * _lineVArray;
}

@property (nonatomic, assign)id<XYNewsPageSelectedDelegate>delegate;
@property (nonatomic, strong)NSMutableArray *subNewsView;
@property (nonatomic, strong)XYHeadPageView * headPageView;

@property (nonatomic, assign)int row;



- (void)setPageArray:(NSArray*)array
           isHasHead:(BOOL)isHasHead
          headArray:(NSArray*)headArray
            delegate:(id)delegate
            row:(int)row;


@end
