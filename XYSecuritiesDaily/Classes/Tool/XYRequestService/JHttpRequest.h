////
////  JHttpRequest.h
////  BuyHouseHD
////
////  Created by Jayla on 12-2-29.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@class ASIHTTPRequest;
//@class ASIFormDataRequest;
//
//@interface JHttpRequest : NSObject
//
////异步Get请求
////+ (ASIHTTPRequest *)asyncGetRequest:(NSString *)url complete:(void (^)(NSString *responseStr))complete failed:(void (^)(NSString *errorMsg))failed;
//
//
//////异步Get请求带缓存
////+ (ASIHTTPRequest *)asyncCacheGetRequest:(NSString *)url
////                                complete:(void (^)(NSString *responseStr))complete
////                                  failed:(void (^)(NSString *errorMsg))failed;
//////异步Post请求
////+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(NSString *responseStr))complete failed:(void (^)(NSString *errorMsg))failed;
////
//////异步Post上传图片
////+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url imageData:(NSData *)imgData complete:(void (^)(NSString *responseStr))complete failed:(void (^)(NSString *errorMsg))failed;
//
//
//
////异步Get请求
//+ (ASIHTTPRequest *)asyncGetRequest:(NSString *)url complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//
////异步Post请求
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//
/////异步post普通请求
//+ (ASIFormDataRequest *)asyncPostJsonRequest:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//
//
//
////异步Post上传图片
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url imageData:(NSData *)imgData complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//+ (ASIFormDataRequest *)asyncPostRequest:(NSString *)url parameters:(NSDictionary*)parameters imageData:(NSData *)imgData complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//
//
////异步下载请求
//+ (ASIHTTPRequest *)asyncDownloadRequest:(NSString *)url complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSString *errorMsg))failed;
//
////生成异步请求对象
//+ (ASIFormDataRequest *)createAsyncRequest:(NSString *)url_ tag:(int)tag;
//+ (ASIFormDataRequest *)createAsyncRequestWithHouse:(NSString *)url_ tag:(int)tag;
//@end
