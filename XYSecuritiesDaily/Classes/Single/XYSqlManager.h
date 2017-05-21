//
//  XYSqlManager.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Model
#import "MDNewsType.h"
#import "MDHeadNews.h"
#import "MDNewsDetail.h"
#import "MDNews.h"
#import "MDComment.h"
#import "MDAdvertisement.h"

//图集
#import "MDImage.h"
#import "MDPhotoDetail.h"

//收藏
#import "MDCollect.h"
#import "MDMessage.h"

//电子报
#import "MDEpaperCalendar.h"
#import "MDEpaper.h"
#import "MDEmailSuffix.h"

#pragma mark - tool
#import "FMDatabase.h"

#define SQL_DATABASE_NAME @"security"

#define SQL_PATH [NSString stringWithFormat:@"%@/Library/Caches/%@.db",NSHomeDirectory(),SQL_DATABASE_NAME]



#pragma mark - 表名
#define TABLE_News          @"tw_news"         //新闻
#define TABLE_NewsType      @"tw_news_type"     //新闻类型
#define TABLE_Comment       @"tw_news_comment"      //跟帖
#define TABLE_Magazine      @"tw_magazine"  //杂志


#define TABLE_HeadNews      @"HeadNews"     //头条
#define TABLE_MyCollect     @"MyCollect"    //收藏

#define TABLE_Photos        @"Photos"       //图集
#define TABLE_PhotoDetail   @"PhotoDetail"  //图集详情

#define TABLE_Message       @"Message"      //我的消息


#define TABLE_EpaperCalendar     @"EpaperCalendar" //电子报日历
#define TABLE_Epaper        @"Epaper" //电子报列表,某天,某版面

#define TABLE_EmailSuffix   @"EmailSuffix"  //邮箱后缀

//#define TABLE_NEWS          @""
//#define TABLE_NEWS @""
//#define TABLE_NEWS @""
//#define TABLE_NEWS @""
//#define TABLE_NEWS @""
//#define TABLE_NEWS @""


#define REQUEST_MESSAGE_CACHE @"暂无网络连接,使用缓存数据"
#define REQUEST_MESSAGE_FAIL @"网络连接失败"
#define REQUEST_MESSAGE_NONE @"暂无相关数据"

@interface XYSqlManager : NSObject

@property (nonatomic,strong)FMDatabase * dataBase;

//获取单利
+ (XYSqlManager *)defaultService;


//插入
- (BOOL)insertItem:(id)item;

//删除
- (BOOL)deleteFromTableName:(NSString*)tableName
                      where:(NSString*)parameters;
//移除表格
- (BOOL)dropFromTableName:(NSString*)tableName;
//修改

//查询
-(NSArray*)selectTableName:(NSString*)tableName
                parameters:(NSArray*)parameters
                     where:(NSString*)parameters2;
//查询个数
- (int)selectCountWithTableName:(NSString*)tableName
                    where:(NSString*)where;
- (BOOL)close;


@end
