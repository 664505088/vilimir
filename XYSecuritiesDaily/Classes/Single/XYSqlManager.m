//
//  XYSqlManager.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYSqlManager.h"

#define DEBUG_TEST 0

@implementation XYSqlManager

static XYSqlManager * _sqlManager;

+ (XYSqlManager *)defaultService{
    @synchronized(self) {
        if (!_sqlManager){
            _sqlManager = [[XYSqlManager alloc] init];
        }
    }
    return _sqlManager;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (_sqlManager == nil) {
            return [super allocWithZone:zone];
        }
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        self.dataBase = [[FMDatabase alloc] initWithPath:SQL_PATH];
        NSLog(@"%@",SQL_PATH);
        if ([_dataBase open]) {
            //创建邮箱后缀表格
            [self createTableName:TABLE_EmailSuffix parameters:@[@"suffix",@"name"]];
            if ([self selectCountWithTableName:TABLE_EmailSuffix where:nil]==0) {
                MDEmailSuffix * suffix1 = [[MDEmailSuffix alloc] initWithName:@"腾讯" suffix:@"@qq.com"];
                [self insertItem:suffix1];
                
                MDEmailSuffix * suffix2 = [[MDEmailSuffix alloc] initWithName:@"@163.com" suffix:@"@163.com"];
                [self insertItem:suffix2];
                
                MDEmailSuffix * suffix3 = [[MDEmailSuffix alloc] initWithName:@"gmail" suffix:@"@gmail.com"];
                [self insertItem:suffix3];
                
                MDEmailSuffix * suffix4 = [[MDEmailSuffix alloc] initWithName:@"新浪" suffix:@"@sina.com.cn"];
                [self insertItem:suffix4];
                
                MDEmailSuffix * suffix5 = [[MDEmailSuffix alloc] initWithName:@"@126.com" suffix:@"@126.com"];
                [self insertItem:suffix5];
                
                MDEmailSuffix * suffix6 = [[MDEmailSuffix alloc] initWithName:@"@yahoo.com.cn" suffix:@"@yahoo.com.cn"];
                [self insertItem:suffix6];
                
                MDEmailSuffix * suffix7 = [[MDEmailSuffix alloc] initWithName:@"@139.com" suffix:@"@139.com"];
                [self insertItem:suffix7];
                
                MDEmailSuffix * suffix8 = [[MDEmailSuffix alloc] initWithName:@"@189.cn" suffix:@"@189.cn"];
                [self insertItem:suffix8];
                
                MDEmailSuffix * suffix9 = [[MDEmailSuffix alloc] initWithName:@"@hotmail.com" suffix:@"@hotmail.com"];
                [self insertItem:suffix9];
                
                MDEmailSuffix * suffix10 = [[MDEmailSuffix alloc] initWithName:@"@live.com" suffix:@"@live.com"];
                [self insertItem:suffix10];
                
                MDEmailSuffix * suffix11 = [[MDEmailSuffix alloc] initWithName:@"@live.cn" suffix:@"@live.cn"];
                [self insertItem:suffix11];
            }
            
            //创建菜单表格
            [self createTableName:TABLE_NewsType
                       parameters:@[@"idString",@"name",@"has_head"]];

            //创建新闻表格
            [self createTableName:TABLE_News
                       parameters:@[@"column_id",@"page",@"idString",@"title",@"title_img",@"shot_title",@"content_summary",@"detail_url"]];
            //创建头条表格
            [self createTableName:TABLE_HeadNews
                       parameters:@[@"column_id",@"idString",@"title",@"head_img",@"shot_title",@"detail_url"]];
            
            //创建跟帖表格
            [self createTableName:TABLE_Comment parameters:@[@"idString",@"from_id",@"is_my",@"column_id",@"my_user_id",@"status",@"page",@"type",@"content",@"create_time",@"news_title",@"user_name",@"parent_user_name",@"parent_content"]];
        
            
            //创建 图集表格
            [self createTableName:TABLE_Photos
                       parameters:@[@"page",@"idString",@"listName",@"descript",@"img_url",@"width",@"height"]];
            
            //创建图集详情表格
            [self createTableName:TABLE_PhotoDetail
                       parameters:@[@"page",@"idString",@"img_width",@"imgName",@"descript",@"gallery_name",@"img_url",@"comment_count"]];
            
            //创建收藏表格
            [self createTableName:TABLE_MyCollect parameters:@[@"column_id",@"page",@"idString",@"type",@"title",@"descript",@"img_url",@"comment_count",@"create_date"]];
            
            
            //创建我的消息表格
            [self createTableName:TABLE_Message parameters:@[@"idString",@"user_id",@"page",@"message",@"create_time"]];
            
            
            //创建日历表格
            [self createTableName:TABLE_EpaperCalendar parameters:@[@"date",@"year",@"month",@"day"]];
            //创建电子报表格
            [self createTableName:TABLE_Epaper parameters:@[@"img",@"pdf",@"year",@"month",@"day",@"title"]];
            
        }
    }
    return self;
}




//创建表格
-(void)createTableName:(NSString*)tableName parameters:(NSArray*)parameters
{
    NSString * param = @"";
    for (int i=0; i<parameters.count; i++) {
        param = [param stringByAppendingFormat:@",%@ TEXT(1024)",[parameters objectAtIndex:i]];
    }
    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(serial integer  PRIMARY KEY AUTOINCREMENT%@)",tableName,param];
    if ([_dataBase executeUpdate:sqlString]) {
        if (DEBUG_TEST) {
            NSLog(@"创建%@表成功",tableName);
        }
    }
    else {
        NSLog(@"创建%@表失败",tableName);
    }
}

//插入数据
- (BOOL)insertItem:(id)item {
    NSString *sql=nil;
    if ([item isKindOfClass:[MDEmailSuffix class]]) {
        MDEmailSuffix * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (name,suffix) values (?,?)",TABLE_EmailSuffix];
        return [_dataBase executeUpdate:sql,tmp.name,tmp.suffix];
    }
    
    if ([item isKindOfClass:[MDNewsType class]]) {//导航item
        MDNewsType * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (idString,name,has_head) values (?,?,?)",TABLE_NewsType];
        return [_dataBase executeUpdate:sql,tmp.idString,tmp.name,tmp.has_head];
    }
    
    else if ([item isKindOfClass:[MDHeadNews class]]) {//新闻头条item
        MDHeadNews * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (column_id,idString,title,head_img,shot_title,detail_url) values (?,?,?,?,?,?)",TABLE_HeadNews];
        return [_dataBase executeUpdate:sql,tmp.column_id,tmp.idString,tmp.title,tmp.head_img,tmp.shot_title,tmp.detail_url];
    }
    
    else if ([item isKindOfClass:[MDNews class]]) {//新闻item
        MDNews * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (column_id,page,idString,title,title_img,shot_title,content_summary,detail_url) values (?,?,?,?,?,?,?,?)",TABLE_News];
        return [_dataBase executeUpdate:sql,
                tmp.column_id, tmp.page,       tmp.idString,   tmp.title,
                tmp.title_img, tmp.shot_title, tmp.content_summary,    tmp.detail_url];
    }
    
    else if ([item isKindOfClass:[MDComment class]]) {//新闻item
        MDComment * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (idString,from_id,is_my,column_id,status,page,type,content,create_time,news_title,user_name,my_user_id,parent_user_name,parent_content) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",TABLE_Comment];
        return [_dataBase executeUpdate:sql,
                tmp.idString,
                tmp.from_id,
                tmp.is_my,
                tmp.column_id,
                tmp.status,
                tmp.page,
                tmp.type,
                tmp.content,
                tmp.create_time,
                tmp.news_title,
                tmp.user_name,
                tmp.my_user_id,
                tmp.parent_user_name,
                tmp.parent_content];
    }
    
    else if ([item isKindOfClass:[MDAdvertisement class]]) {//广告item
        
    }

    
    else if ([item isKindOfClass:[MDImage class]]) {//图集
        MDImage * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (page,idString,listName,descript,img_url,width,height) values (?,?,?,?,?,?,?)",TABLE_Photos];
        return [_dataBase executeUpdate:sql,
                tmp.page,
                tmp.idString,
                tmp.listName,
                tmp.descript,
                tmp.img_url,
                tmp.width,
                tmp.height];
    }

    else if ([item isKindOfClass:[MDPhotoDetail class]]) {//图集详情
        MDPhotoDetail * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (idString,img_width,page,imgName,descript,gallery_name,img_url,comment_count) values (?,?,?,?,?,?,?,?)",TABLE_PhotoDetail];
        return [_dataBase executeUpdate:sql,
                tmp.idString,
                tmp.img_width,
                tmp.page,
                tmp.imgName,
                tmp.descript,
                tmp.gallery_name,
                tmp.img_url,
                tmp.comment_count];
    }
    else if ([item isKindOfClass:[MDCollect class]]) {//收藏
        MDCollect * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (type,column_id,idString,page,title,descript,img_url,comment_count,create_date) values (?,?,?,?,?,?,?,?,?)",TABLE_MyCollect];
        return [_dataBase executeUpdate:sql,
                tmp.type,
                tmp.column_id,
                tmp.idString,
                tmp.page,
                tmp.title,
                tmp.descript,
                tmp.img_url,
                tmp.comment_count,
                tmp.create_date];
    }
    
    else if ([item isKindOfClass:[MDMessage class]]) {//我的消息
        MDMessage * tmp = item;
        //删除原数据
//        [self deleteFromTableName:TABLE_Message
//                            where:[NSString stringWithFormat:@"idString=\"%@\" and page=\"%@\"",tmp.idString,tmp.page]];
        
        sql = [NSString stringWithFormat:@"insert into %@ (idString,user_id,page,message,create_time) values (?,?,?,?,?)",TABLE_Message];
        return [_dataBase executeUpdate:sql,
                tmp.idString,
                tmp.user_id,
                tmp.page,
                tmp.message,
                tmp.create_time];
    }
    else if ([item isKindOfClass:[MDEpaperCalendar class]]) {//收藏
        MDEpaperCalendar * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (date,year,month,day) values (?,?,?,?)",TABLE_EpaperCalendar];
        return [_dataBase executeUpdate:sql,
                tmp.date,
                tmp.year,
                tmp.month,
                tmp.day];
    }
    else if ([item isKindOfClass:[MDEpaper class]]) {//收藏
        MDEpaper * tmp = item;
        sql = [NSString stringWithFormat:@"insert into %@ (year,month,day,title,img,pdf) values (?,?,?,?,?,?)",TABLE_Epaper];
        return [_dataBase executeUpdate:sql,
                tmp.year,
                tmp.month,
                tmp.day,
                tmp.title,
                tmp.img,
                tmp.pdf];
    }
    
    return NO;
}




//删除
- (BOOL)deleteFromTableName:(NSString*)tableName
                      where:(NSString *)parameters{
    NSString * sql = [NSString stringWithFormat:@"delete from %@",tableName];
    if (parameters!=nil) {
        sql = [sql stringByAppendingFormat:@" where %@",parameters];
    }
    return [_dataBase executeUpdate:sql];
}
///移除表格
- (BOOL)dropFromTableName:(NSString*)tableName {
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if (![_dataBase executeUpdate:sqlstr])
    {
        NSLog(@"Delete table error!");
        return NO;
    }
    return YES;
}
///增加字段0增加,1删除,2改表名字
- (BOOL)Field:(NSString*)Field
       tableName:(NSString*)tableName
         type:(int)type{
    NSString * sql;
    switch (type) {
        //增加字段
        case 0:sql = [NSString stringWithFormat:@"alter table %@ add %@ TEXT(1024)",tableName,Field];break;
        //删除字段
        case 1:sql = [NSString stringWithFormat:@"alter table %@ add %@ TEXT(1024)",tableName,Field];break;
        //给表改名字
        case 2:sql = [NSString stringWithFormat:@"alter table %@ rename to %@",tableName,Field];break;
        //给字段改名字
//        case 3:sql = [NSString stringWithFormat:@"alter table %@ rename column %@ to %@",tableName,Field];break;
    }
    return [_dataBase executeUpdate:sql];
}


//查询数据
-(NSArray*)selectTableName:(NSString*)tableName
                parameters:(NSArray*)parameters
                     where:(NSString*)parameters2 {
    NSString * canshu = @"";
    for (NSString* key in parameters) {
        canshu = [canshu stringByAppendingFormat:@"%@,",key];
    }
    canshu = [canshu substringWithRange:NSMakeRange(0, canshu.length-1)];
    NSString *sql=[NSString stringWithFormat:@"select %@ from %@",canshu,tableName];
    if (parameters2 != nil) {
        sql = [sql stringByAppendingFormat:@" where %@",parameters2];
    }
    //执行查询,将结果保存在rs对象中
    //查询用executeQuery方法
    NSLog(@"%@",sql);
    FMResultSet *rs=[_dataBase executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        id obj = [self objectValueWithTableName:tableName ResultSet:rs];
        if (obj) {
            [array addObject:obj];
        }
    }
    return array;
}

- (id)objectValueWithTableName:(NSString*)tableName
                     ResultSet:(FMResultSet*)rs {
    if ([tableName isEqualToString:TABLE_EmailSuffix]) {
        return [[MDEmailSuffix alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_NewsType]) {
        return [[MDNewsType alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_HeadNews]) {
        return [[MDHeadNews alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_News]) {
        return [[MDNews alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_Comment]) {
        return [[MDComment alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_Photos]) {
        return [[MDImage alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_PhotoDetail]) {
        return [[MDPhotoDetail alloc] initWithResultSet:rs];
    }
    else if ([tableName isEqualToString:TABLE_MyCollect]) {
        return [[MDCollect alloc] initWithResultSet:rs];
    }
    
    else if ([tableName isEqualToString:TABLE_Message]) {
        return [[MDMessage alloc] initWithResultSet:rs];
    }
    
    else if ([tableName isEqualToString:TABLE_EpaperCalendar]) {
        return [[MDEpaperCalendar alloc] initWithResultSet:rs];
    }
    
    else if ([tableName isEqualToString:TABLE_Epaper]) {
        return [[MDEpaper alloc] initWithResultSet:rs];
    }
    return nil;
}


- (int)selectCountWithTableName:(NSString*)tableName
                          where:(NSString*)where {
    NSString *sql=[NSString stringWithFormat:@"select count(*) from %@",tableName];
    if (where != nil) {
        sql = [sql stringByAppendingFormat:@" where %@",where];
    }
    //执行查询,将结果保存在rs对象中
    //查询用executeQuery方法
    FMResultSet *rs=[_dataBase executeQuery:sql];
    while ([rs next]) {
        return [rs intForColumn:@"count(*)"];
    }
    return 0;
}

//关闭
- (BOOL)close {
    return [_dataBase close];
}
@end
