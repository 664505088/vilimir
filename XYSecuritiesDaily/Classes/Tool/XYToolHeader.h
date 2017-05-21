//
//  XYToolHeader.h
//  aaaaa
//
//  Created by xiwang on 14-6-11.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#ifndef aaaaa_XYToolHeader_h
#define aaaaa_XYToolHeader_h


/*
 arc +
 -fno-objc-arc
 
 search header  +
    /usr/include/libxml2
 
 导入类库  +
 libsqlite3.dylib
 libxml2.dylib
 libz1.1.3.dylib
 mobileCoreServices.framework
 CFNetwork.framework
 SystemConfiguration.framework
 CoreText.framework
 
 
 shareSDK~~~~
 QuartzCore.framework
 CoreTelephony.framework
 libicucore.dylib
 Security.framework
 MessageUI.framework
 libstdc++.dylib 
 
 CoreMotion.framework        如果不使用Google+可以不添加
 CoreLocation.framework        如果不使用Google+可以不添加
 MediaPlayer.framework        如果不使用Google+可以不添加
 CoreText.framework        如果不使用Google+可以不添加
 AssetsLibrary.framework        如果不使用Google+可以不添加
 AddressBook.framework        如果不使用Google+可以不添加
 如果不集成邮件和短信可以不添加
 */
#import "XYDevice.h"


#import "UIImageView+WebCache.h"

#import "XYSqlManager.h"
#import "XYEditManager.h"
#import "Reachability.h"
#import "RequestService.h"

#import "XYFactory.h"
#import "SVProgressHUD.h"


#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WXApi.h"
//#import "GDataXMLNode.h"





#endif
