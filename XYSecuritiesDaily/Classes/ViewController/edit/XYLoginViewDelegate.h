//
//  XYLoginViewDelegate.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-20.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYLoginViewController;
@protocol XYLoginViewDelegate <NSObject>

- (void)loginViewDidFinshed:(XYLoginViewController*)vc;

@end
