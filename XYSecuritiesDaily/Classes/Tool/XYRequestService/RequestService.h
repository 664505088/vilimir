//
//  RequestService.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-21.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestURL.h"
//#import "JHttpRequest.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//定义服务器响应码
typedef enum {
	RequestStatus_OK = 200,
    RequestStatus_ErrorRequest = 400,
    RequestStatus_NotFound = 404,
    RequestStatus_Error = 500,
}RequestStatus;

@interface RequestService : NSObject


@property (nonatomic, strong)ASINetworkQueue * queue;
//获取单利
+ (RequestService *)defaultService;

//队列停止加载
- (void)resetDownQueue;


//post二进制上传
- (void)getFromRequestUrl:(NSString*)url
               parameters:(NSDictionary  *)param
                  success:(void (^) (id obj))success
                    falid:(void (^) (NSString *errorMsg))faild;
- (void)getJsonRequestUrl:(NSString *)url
               parameters:(NSDictionary *)param
                imageData:(NSData*)data
                  success:(void (^)(NSString * stringData))success
                    falid:(void (^)(NSString *errorMsg))faild;

//网络请求
///xx=xx&xx=xx参数请求
- (void)getJsonRequestUrl:(NSString*)url  parameters:(NSDictionary  *)param  success:(void (^) (id obj))success falid:(void (^) (NSString *errorMsg))faild;
///xml参数请求
- (void)getUrl:(NSString*)url  parameters:(NSDictionary  *)param  success:(void (^) (NSString* stringData))success falid:(void (^) (NSString *errorMsg))faild;


- (void)getRequestWithParameters:(NSDictionary  *)param  success:(void (^) (GDataXMLElement* root))success falid:(void (^) (NSString *errorMsg))faild;

@end
