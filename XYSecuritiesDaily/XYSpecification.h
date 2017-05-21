//
//  XYSpecification.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-7-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#ifndef XYSecuritiesDaily_XYSpecification_h
#define XYSecuritiesDaily_XYSpecification_h

/*
              数据获取结构图
                 判断网络
                    v
          有                 无
          v                  v
     ok    fail    --->     sql
      v      v    |
   插入数据    -----       0条    n条
 
     sql                  1页    n页     显示
 
   0条  n条               大提示 小提示 提示使用缓存
 
   1页  n页      显示
 
 大提示 小提示
 
*/




/*
            数据替换结构图
                
 */




#endif
