//
//  MDEmailSuffix.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-1.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYObject.h"

@interface MDEmailSuffix : XYObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * suffix;

- (id)initWithName:(NSString*)name suffix:(NSString*)suffix;

@end
