//
//  RequestService.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-21.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "RequestService.h"
#import "GDataXMLNode.h"
@implementation RequestService



static RequestService *requestService;


#pragma mark - 实例化
+ (RequestService *)defaultService {
    @synchronized(requestService) {
        if (!requestService){
            requestService = [[RequestService alloc] init];
        }
    }
    return requestService;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (requestService == nil) {
            return [super allocWithZone:zone];
        }
    }
    return nil;
}
- (id)init {
    self = [super init];
    if (self) {
        self.queue = [[ASINetworkQueue alloc] init];
        [_queue reset];
        [_queue setShowAccurateProgress:YES];
        [_queue go];
    }
    return self;
}



//地址utf8编码
- (NSString *)urlEncodeValue:(NSString *)str
{
    CFStringRef result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8);
    return (__bridge NSString *)result;
}

#pragma attr
- (void)resetDownQueue {
	[_queue cancelAllOperations];
}


//参数转换成xml各式
- (NSMutableData*)paramsDataValue:(NSDictionary*)params {
    
    NSString * canshu = @"<?xml version='1.0' encoding='utf-8'?><dns version=''>";
    //设置请求参数
    if (params != nil) {
        NSArray *parameterKeys_ = [params allKeys];
        for (int i=0; i<[parameterKeys_ count]; i++) {
            id key_ = [parameterKeys_ objectAtIndex:i];
            id value_ = [params objectForKey:key_];
            //			[request setPostValue:value_ forKey:key_];
            canshu = [canshu stringByAppendingFormat:@"<%@>%@</%@>",key_,value_,key_];
            
        }
    }
    canshu = [canshu stringByAppendingString:@"</dns>"];
    NSMutableData *postData = (NSMutableData *)[canshu dataUsingEncoding:NSUTF8StringEncoding];
    return postData;
}

#pragma mark - 网络请求
- (void)getUrl:(NSString*)url  parameters:(NSDictionary  *)param  success:(void (^) (NSString* stringData))success falid:(void (^) (NSString *errorMsg))faild
{
    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	[theRequest setRequestMethod:@"POST"];
    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
    [theRequest addRequestHeader:@"Content-Type" value:@"text/xml"];
    [theRequest addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/"];
    NSMutableData *data= [self paramsDataValue:param];
    
    
    [theRequest setPostBody:data];
    [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
    [theRequest setTimeOutSeconds:10.0];
    
    
    NSLog(@"请求参数:%@",param);

    //请求成功
    ASIFormDataRequest * request = theRequest;
    [theRequest setCompletionBlock:^{
        NSString * str = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@返回数据 :\n%@",[param objectForKey:@"mode"],str);
        if (str.length >0) {
            if (success) {
                success(str);
            }
        }else {
            if (faild) {
                faild(@"接口返回数据未空");
            }
        }
    }];
    
    //请求失败
    [theRequest setFailedBlock:^{
        faild(@"网络连接失败,请稍后在试...");
    }];
    
    //开始请求
    [_queue addOperation:request];
//    [theRequest startAsynchronous];
}



- (void)getFromRequestUrl:(NSString *)url parameters:(NSDictionary *)param success:(void (^)(id))success falid:(void (^)(NSString *))faild {
    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	[theRequest setRequestMethod:@"POST"];
    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
    [theRequest addRequestHeader:@"Content-Type" value:@"text/xml"];
    [theRequest addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/"];
    NSMutableData *data= [self paramsDataValue:param];
    
    
    [theRequest setPostBody:data];
    [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
    [theRequest setTimeOutSeconds:10.0];
    
    
    NSLog(@"请求参数:%@",param);
    //    NSLog(@"请求地址:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //请求成功
    ASIFormDataRequest * request = theRequest;
    [theRequest setCompletionBlock:^{
        if (request.responseData) {
            NSString * str = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
            if (success) {
                success(str);
            }
        }
        else {
            if (faild) {
                faild(@"接口返回数据未空");
            }
        }
    }];
    
    //请求失败
    [theRequest setFailedBlock:^{
        if (faild) {
            faild(@"网络连接失败,请稍后在试...");
        }
    }];
    
    //开始请求
//    [theRequest startAsynchronous];
    [_queue addOperation:request];
}

- (void)getRequestWithParameters:(NSDictionary  *)param  success:(void (^) (GDataXMLElement* root))success falid:(void (^) (NSString *errorMsg))faild
{
    
    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST]];
	[theRequest setRequestMethod:@"POST"];
    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
    [theRequest addRequestHeader:@"Content-Type" value:@"text/xml"];
    [theRequest addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/"];
    NSMutableData *data= [self paramsDataValue:param];
    
    
    [theRequest setPostBody:data];
    [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
    [theRequest setTimeOutSeconds:10.0];
    
    
    NSLog(@"请求参数:%@",param);
    //    NSLog(@"请求地址:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //请求成功
    ASIFormDataRequest * request = theRequest;
    [theRequest setCompletionBlock:^{
        if (request.responseData) {
            NSString * str = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
            NSLog(@"%@返回数据 :\n%@",[param objectForKey:@"mode"],str);
            //取到根节点
            GDataXMLDocument * document= [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
            GDataXMLElement * rootElement = [document rootElement];
            
            NSString * result = [[[rootElement elementsForName:@"result"] firstObject] stringValue];
            NSString * msg = [[[rootElement elementsForName:@"msg"] firstObject] stringValue];
            if ([result isEqualToString:@"no"] && [msg isEqualToString:@"操作错误"]) {
                NSLog(@"服务器错误");
                faild(msg);
            }else {
                if (success) {
                    success(rootElement);
                }
            }
        }
        else {
            if (faild) {
                NSLog(@"无法连接服务器");
                faild(@"无法连接服务器");
            }
        }
    }];
    
    //请求失败
    [theRequest setFailedBlock:^{
        if (faild) {
            faild(@"网络连接失败,请稍后在试...");
        }
    }];
    
    //开始请求
//    [theRequest startAsynchronous];
    [_queue addOperation:request];
}


- (void)getJsonRequestUrl:(NSString*)url  parameters:(NSDictionary  *)param  success:(void (^) (id obj))success falid:(void (^) (NSString *errorMsg))faild
{
  
    ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	[theRequest setRequestMethod:@"POST"];
    theRequest.shouldAttemptPersistentConnection=NO;//设置关闭长连接
    NSString * dataStr = @"";
    for (NSString * key in [param allKeys]) {
        NSString * value = [param objectForKey:key];
        dataStr = [dataStr stringByAppendingFormat:@"&%@=%@",key,value];
    }
    if (dataStr.length>1) {
        dataStr = [dataStr substringWithRange:NSMakeRange(1, dataStr.length-1)];
        NSMutableData *data= (NSMutableData*)[dataStr dataUsingEncoding:NSUTF8StringEncoding];
        
        [theRequest setPostBody:data];
        [theRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]]];
        //        NSLog(@"请求参数:%@",params);
        NSLog(@"请求地址:%@?%@",url,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
    
    [theRequest setTimeOutSeconds:5.0];
    
    
    
    
    //请求成功
    ASIFormDataRequest * request = theRequest;
    [theRequest setCompletionBlock:^{
        if (request.responseData) {
            NSString* str = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
            NSLog(@"%@返回数据 :\n%@",[param objectForKey:@"mode"],str);
            NSError *error;
            id _obj = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:&error];
            success(_obj);
        }else {
            faild(@"服务器错误");
        }
    }];
    
    //请求失败
    [theRequest setFailedBlock:^{
        faild(@"网络连接失败,请稍后在试...");
    }];
    
    //开始请求
    [_queue addOperation:request];
//    [theRequest startAsynchronous];
}

///上传图片
- (void)getJsonRequestUrl:(NSString *)url
               parameters:(NSDictionary *)param
                imageData:(NSData*)data
                  success:(void (^)(NSString * stringData))success
                    falid:(void (^)(NSString *errorMsg))faild {
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    for (NSString * _key in [param allKeys]) {
        NSString * _value = [param objectForKey:_key];
        [request setPostValue:_value forKey:_key];
    }
    
    [request setUseKeychainPersistence:YES];
    [request addPostValue:@"touxiang.png" forKey:@"imageFileName"];
    [request addData:data withFileName:@"touxiang.png" andContentType:@"image/png"
              forKey:@"image"];
    [request addPostValue:@"touxiang.png" forKey:@"imageFileName"];
    [request buildRequestHeaders];
    [request buildPostBody];
    [request setTimeOutSeconds:15];
    [request setRequestMethod:@"POST"];
    request.shouldAttemptPersistentConnection = NO;
    [request buildPostBody];
    
    
    //请求成功
    ASIFormDataRequest *theRequest = request;
    [request setCompletionBlock:^{
        switch (theRequest.responseStatusCode) {
            case RequestStatus_OK:{
                
                NSString * string = [[NSString alloc] initWithData:theRequest.responseData encoding:NSUTF8StringEncoding];
                NSLog(@"%@返回数据 :\n%@",[param objectForKey:@"mode"],string);
                if (string.length>0) {
                    success(string);
                }else {
                    faild(@"返回数据为空");
                }
            }break;
            case RequestStatus_ErrorRequest:
                faild(@"错误的请求");break;
            case RequestStatus_NotFound:
                faild(@"找不到指定的资源");break;
            case RequestStatus_Error:
                faild(@"内部服务器错误");break;
            default:
                faild(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        faild([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
    }];
    //开始请求
    [_queue addOperation:request];

}
@end
