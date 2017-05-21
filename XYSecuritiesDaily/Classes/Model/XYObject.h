//
//  XYObject.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-29.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
@class GDataXMLElement;

@interface XYObject : NSObject

- (id)initWithElement:(GDataXMLElement*)element;
- (id)initWithResultSet:(FMResultSet*)rs;

@end
