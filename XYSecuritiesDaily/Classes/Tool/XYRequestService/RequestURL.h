//
//  RequestURL.h
//  aaaaa
//
//  Created by xiwang on 14-6-11.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#ifndef aaaaa_RequestURL_h
#define aaaaa_RequestURL_h

#pragma mark - 设置服务器地址
//测试
//#define PART @"http://test7.ps.cn/security"
//发布
#define PART @"http://app.ccstock.cn"




//主机
#define HOST [NSString stringWithFormat:@"%@/terminal/terminal.action",PART]
//上传文件
#define HOST_UPLOADING [NSString stringWithFormat:@"%@/terminal/terminal!uploadFile",PART]







#pragma mark - APP_INFO
#define APP_ID @"441894234"
///检测版本
#define APP_VERSION [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@&country=cn",APP_ID]
///评分
#define APP_GRADE [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",APP_ID]




#pragma mark - 第三方分享
///shareSDK
#define ShareSDK_RegisterApp @"e38afd419d0"

///新浪微博
//#define Sina_AppKey   @"341377248"//iphone客户端使用的
//#define Sina_AppSecret @"bb4dfea420c57c714bafa12d2537224d"//iphone客户端使用的
#define Sina_AppKey   @"376265125"
#define Sina_AppSecret @"1d8965f0e8297fb86f506d2fd4ef33b0"
#define Sina_RedirectUri @"http://www.ccstock.cn"

///腾讯微博
#define Tencent_AppKey @"801249915"
#define Tencent_AppSecret @"d855e039fc773030db98b8518d5f14a7"
#define Tencent_RedirectUri @"http://www.ccstock.cn"

///网易微博
#define Nets_AppKey @"T5EI7BXe13vfyDuy"
#define Nets_AppSecret @"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
#define Nets_RedirectUri @"http://www.shareSDK.cn"//shareSDK

///微信
#define Tencent_WeChatAppId @"wx5798c3158a8d4998"//π













#pragma mark - mode
///loading页面
#define MODE_1_8 @"pad_1.8"


#endif
