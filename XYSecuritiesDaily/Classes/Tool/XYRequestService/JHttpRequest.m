////
////  JHttpRequest.m
////  BuyHouseHD
////
////  Created by Jayla on 12-2-29.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import "JHttpRequest.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
//#import "ASIDownloadCache.h"
//
//
//#define UserAgent  @"YUNIN 1.0"
//#define TimeOut 20
//#define RetryTimes 2
//
//
////定义服务器响应码
//typedef enum {
//	RequestStatus_OK = 200,
//    RequestStatus_ErrorRequest = 400,
//    RequestStatus_NotFound = 404,
//    RequestStatus_Error = 500,
//}RequestStatus;
//
//
//@implementation JHttpRequest
//
//#pragma mark private
///**************************************************************************************/
////参数转换成xml各式
//+ (NSMutableData*)paramsDataValue:(NSDictionary*)params {
//    
//    NSString * canshu = @"<?xml version='1.0' encoding='utf-8'?><dns version=''>";
//    //设置请求参数
//    if (params != nil) {
//        NSArray *parameterKeys_ = [params allKeys];
//        for (int i=0; i<[parameterKeys_ count]; i++) {
//            id key_ = [parameterKeys_ objectAtIndex:i];
//            id value_ = [params objectForKey:key_];
//    //			[request setPostValue:value_ forKey:key_];
//            canshu = [canshu stringByAppendingFormat:@"<%@>%@</%@>",key_,value_,key_];
//
//        }
//    }
//    canshu = [canshu stringByAppendingString:@"</dns>"];
//    NSMutableData *postData = (NSMutableData *)[canshu dataUsingEncoding:NSUTF8StringEncoding];
//    return postData;
//}
//+ (ASIHTTPRequest *)requestWithUrl:(NSString *)urlStr{
//   // NSLog(@"请求地址:%@",urlStr);
//    
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//    
//    //设置超时
//    [request setTimeOutSeconds:TimeOut];//设置超时时间
//    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];//超时重试次数
//    
//    //设置缓存
////    [request setDownloadCache:[ASIDownloadCache sharedCache]];//设置下载缓存
////    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];//缓存策略
////    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy];
////    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];//缓存存储方式
////    [request setSecondsToCache:60*60*24*30];// 缓存30天
//    
//    return [request autorelease];
//}
//
//+ (ASIFormDataRequest *)formRequestWithUrl:(NSString *)urlStr{
//   // NSLog(@"请求地址:%@",urlStr);
//    
//    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//
//    //设置超时
//    [request setTimeOutSeconds:TimeOut];//设置超时时间
//    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];//超时重试次数
//    
//    //设置缓存
////    [request setDownloadCache:[ASIDownloadCache sharedCache]];//设置下载缓存
////    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];//缓存策略
////    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];//缓存存储方式
////    [request setSecondsToCache:60*60*24*30];// 缓存30天
//    
//    return [request autorelease];
//}
//
//#pragma mark public
///**************************************************************************************/
////发送异步Get请求
//+ (ASIHTTPRequest *)asyncGetRequest:(NSString *)url
//               complete:(void (^)(NSData *responseStr))complete
//                 failed:(void (^)(NSString *errorMsg))failed{
//    
//    ASIHTTPRequest *request = [self requestWithUrl:url];
//    [request setTimeOutSeconds:5.];
//    //请求成功
//    [request setCompletionBlock:^{
//        switch (request.responseStatusCode) {
//            case RequestStatus_OK:
//                complete(request.responseData);break;
//            case RequestStatus_ErrorRequest:
//                failed(@"错误的请求");break;
//            case RequestStatus_NotFound:
//                failed(@"找不到指定的资源");break;
//            case RequestStatus_Error:
//                failed(@"内部服务器错误");break;
//            default:
//                failed(@"服务器出错");break;
//        }
//    }];
//    
//    //请求失败
//    [request setFailedBlock:^{
//        failed(@"网络连接失败");
//    }];
//    
//    //开始请求
//    [request startAsynchronous];
//    return request;
//}
///**************************************************************************************/
////异步Post上传图片
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url imageData:(NSData *)imgData complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed{
//    ASIFormDataRequest* request = [self formRequestWithUrl:url];
////    request.showAccurateProgress = YES;
////    request.uploadProgressDelegate = viewPost.progressView;
//    request.shouldContinueWhenAppEntersBackground = YES;
//    [request setPostFormat:ASIMultipartFormDataPostFormat];
//    [request addData:imgData withFileName:@"123" andContentType:@"image/png" forKey:@"photos[]"];
//    //请求成功
//    [request setCompletionBlock:^{
//        switch (request.responseStatusCode) {
//            case RequestStatus_OK:
//                complete(request.responseData);break;
//            case RequestStatus_ErrorRequest:
//                failed(@"错误的请求");break;
//            case RequestStatus_NotFound:
//                failed(@"找不到指定的资源");break;
//            case RequestStatus_Error:
//                failed(@"内部服务器错误");break;
//            default:
//                failed(@"服务器出错");break;
//        }
//    }];
//    
//    //请求失败
//    [request setFailedBlock:^{
//        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
//    }];
//    
//    //开始请求
//    [request startAsynchronous];
//    return request;
//
//}
//
////异步Post上传图片
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url parameters:(NSDictionary*)parameters imageData:(NSData *)imgData complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed{
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//    for (NSString * _key in [parameters allKeys]) {
//        NSString * _value = [parameters objectForKey:_key];
//        [request setPostValue:_value forKey:_key];
//    }
//    
//    [request setUseKeychainPersistence:YES];
//    [request addPostValue:@"touxiang.png" forKey:@"imageFileName"];
//    [request addData:imgData withFileName:@"touxiang.png" andContentType:@"image/png"
//                  forKey:@"image"];
//    [request addPostValue:@"touxiang.png" forKey:@"imageFileName"];
//    [request buildRequestHeaders];
//    [request buildPostBody];
//    [request setTimeOutSeconds:15];
//    [request setRequestMethod:@"POST"];
//    request.shouldAttemptPersistentConnection = NO;
//    [request buildPostBody];
//    
//    
////请求成功
//    [request setCompletionBlock:^{
//        switch (request.responseStatusCode) {
//            case RequestStatus_OK:
//                complete(request.responseData);break;
//            case RequestStatus_ErrorRequest:
//                failed(@"错误的请求");break;
//            case RequestStatus_NotFound:
//                failed(@"找不到指定的资源");break;
//            case RequestStatus_Error:
//                failed(@"内部服务器错误");break;
//            default:
//                failed(@"服务器出错");break;
//        }
//    }];
//    //请求失败
//    [request setFailedBlock:^{
//        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
//    }];
//    //开始请求
//    [request startAsynchronous];
//    return request;
//
//    
//}
////异步Post请求
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url
//              parameters:(NSDictionary *)params
//                complete:(void (^)(NSData *responseData))complete
//                  failed:(void (^)(NSString *errorMsg))failed{
//    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//	[theRequest setRequestMethod:@"POST"];
//    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
//    [theRequest addRequestHeader:@"Content-Type" value:@"text/xml"];
//    [theRequest addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/"];
//    NSMutableData *data= [self paramsDataValue:params];
//
//
//    [theRequest setPostBody:data];
//    [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
//    [theRequest setTimeOutSeconds:10.0];
//
//
//    NSLog(@"请求参数:%@",params);
////    NSLog(@"请求地址:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    //请求成功
//    [theRequest setCompletionBlock:^{
//        complete(theRequest.responseData);
//    }];
//    
//    //请求失败
//    [theRequest setFailedBlock:^{
//        failed(@"网络连接失败,请稍后在试...");
//    }];
//    
//    //开始请求
//    [theRequest startAsynchronous];
//    return theRequest;
//}
//
////异步下载请求
//+ (ASIHTTPRequest *)asyncDownloadRequest:(NSString *)url
//                    complete:(void (^)(NSData *responseData))complete
//                      failed:(void (^)(NSString *errorMsg))failed{
//    
//    ASIHTTPRequest *request = [self requestWithUrl:url];
//    
//    //下载完成
//    [request setDataReceivedBlock:^(NSData *data) {
//        switch (request.responseStatusCode) {
//            case RequestStatus_OK:
//                complete(data);break;
//            case RequestStatus_ErrorRequest:
//                failed(@"错误的请求");break;
//            case RequestStatus_NotFound:
//                failed(@"找不到指定的资源");break;
//            case RequestStatus_Error:
//                failed(@"内部服务器错误");break;
//            default:
//                failed(@"服务器出错");break;
//        }
//    }];
//    
//    //请求失败
//    [request setFailedBlock:^{
//        failed([NSString stringWithFormat:@"未知错误:%@",[request.error localizedDescription]]);
//    }];
//    
//    //开始请求
//    [request startAsynchronous];
//    return request;
//}
//
//+ (ASIFormDataRequest *)createAsyncRequestWithHouse:(NSString *)url_ tag:(int)tag {
//	NSString *url = url_;
//	
//	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setRequestMethod:@"GET"];
//
//    
//    //    
//    	[request addRequestHeader:@"Host" value:@"http://223.4.234.44:30019"];
//    	[request addRequestHeader:@"Refresh" value:@"http://223.4.234.44:30019"];
//    //	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
//    //	[request addRequestHeader:@"Accept-Encoding" value:@"gzip, deflate"];
//    //	[request addRequestHeader:@"Accept-Charset" value:@"ISO-8859-1,utf-8;q=0.7,*;q=0.7"];
//    //	[request addRequestHeader:@"Connection" value:@"keep-alive"];
//    //	[request addRequestHeader:@"Cookie" value:@"ASP.NET_SessionId=ri3rjg45t5rttp2n1gi2cpqh"];
//    //	//	[request addRequestHeader:@"If-Modified-Since" value:@"Wed, 05 Oct 2011 07:02:46 GMT"];
//    //	//	[request addRequestHeader:@"If-None-Match" value:@"\"448fec92c83cc1:2930\""];
//    //	[request addRequestHeader:@"Cache-Control" value:@"max-age=0"];
//    //	//	[request addRequestHeader:@"(Request-Line)" value:@"web32818.w131.vhost002.cn"];
//	
//	NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",tag] forKey:@"t_tag"];
//	[request setUserInfo:userInfo];
//	
//	[request setTimeOutSeconds:TimeOut];
//	
//	return [request autorelease];
//}
//
//+ (ASIFormDataRequest *)createAsyncRequest:(NSString *)url_ tag:(int)tag {
//	NSString *url = url_;
//	
//	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setRequestMethod:@"GET"];
//    
////    
////	[request addRequestHeader:@"Host" value:SERVICE_DOMAIN];
////	[request addRequestHeader:@"Refresh" value:SERVICE_DOMAIN];
////	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
////	[request addRequestHeader:@"Accept-Encoding" value:@"gzip, deflate"];
////	[request addRequestHeader:@"Accept-Charset" value:@"ISO-8859-1,utf-8;q=0.7,*;q=0.7"];
////	[request addRequestHeader:@"Connection" value:@"keep-alive"];
////	[request addRequestHeader:@"Cookie" value:@"ASP.NET_SessionId=ri3rjg45t5rttp2n1gi2cpqh"];
////	//	[request addRequestHeader:@"If-Modified-Since" value:@"Wed, 05 Oct 2011 07:02:46 GMT"];
////	//	[request addRequestHeader:@"If-None-Match" value:@"\"448fec92c83cc1:2930\""];
////	[request addRequestHeader:@"Cache-Control" value:@"max-age=0"];
////	//	[request addRequestHeader:@"(Request-Line)" value:@"web32818.w131.vhost002.cn"];
//	
//	NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",tag] forKey:@"t_tag"];
//	[request setUserInfo:userInfo];
//	
//	[request setTimeOutSeconds:TimeOut];
//	
//	return [request autorelease];
//}
//
//
//
//
//
//
//
//
//#pragma mark - 追加
////异步Post请求
////?xxx=xxx&xxx=xxx
//+ (ASIFormDataRequest *)asyncPostJsonRequest:(NSString *)url
//                              parameters:(NSDictionary *)params
//                                complete:(void (^)(NSData *responseData))complete
//                                  failed:(void (^)(NSString *errorMsg))failed{
//    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//	[theRequest setRequestMethod:@"POST"];
//    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
//    NSString * dataStr = @"";
//    for (NSString * key in [params allKeys]) {
//        NSString * value = [params objectForKey:key];
//        dataStr = [dataStr stringByAppendingFormat:@"&%@=%@",key,value];
//    }
//    if (dataStr.length>1) {
//        dataStr = [dataStr substringWithRange:NSMakeRange(1, dataStr.length-1)];
//        NSMutableData *data= (NSMutableData*)[dataStr dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [theRequest setPostBody:data];
//        [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
////        NSLog(@"请求参数:%@",params);
//        NSLog(@"请求地址:%@?%@",url,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }
//
//    [theRequest setTimeOutSeconds:5.0];
//    
//    
//    
//    
//    //请求成功
//    [theRequest setCompletionBlock:^{
//        complete(theRequest.responseData);
//    }];
//    
//    //请求失败
//    [theRequest setFailedBlock:^{
//        failed(@"网络连接失败,请稍后在试...");
//    }];
//    
//    //开始请求
//    [theRequest startAsynchronous];
//    return theRequest;
//}
//@end
