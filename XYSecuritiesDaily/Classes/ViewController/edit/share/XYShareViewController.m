//
//  XYShareViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-18.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYShareViewController.h"

#import "XYShareView.h"
#import "XYShareEditView.h"
@interface XYShareViewController ()
{
    XYShareView          * _shareTypeView;
    XYShareEditView      * _shareEditView;
    ShareType            _type;
}
@end

@implementation XYShareViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xView.frame = CGRectMake((H_WIDTH-340)/2, (H_HEIGHT-486)/2, 340, 486);
    _shareTypeView = [[XYShareView alloc] initWithFrame:self.xView.bounds];
    [self.xView addSubview:_shareTypeView];
    
    for (int i=0; i<_shareTypeView.buttons.count; i++) {
        UIButton * btn =  [_shareTypeView.buttons objectAtIndex:i];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickShareTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self scaleAnimation];
}
#pragma mark - 点击

//选中某微博类型
- (void)clickShareTypeWithButton:(UIButton*)btn {
    switch (btn.tag) {
        case 0:_type = ShareTypeSinaWeibo;break;
        case 1:_type = ShareTypeTencentWeibo;break;
        case 2:_type = ShareType163Weibo;break;
        case 3:_type = ShareTypeWeixiSession;[self sendWeixinFriend];return;
        case 4:_type = ShareTypeWeixiTimeline;[self sendTimelineNewsContent];return;
        default:[SVProgressHUD showErrorWithStatus:@"微博类型选择错误"];return;
    }
    if ([ShareSDK hasAuthorizedWithType:_type]) {
        self.xView.frame = CGRectMake(210, STATUS_HEIGHT+55, 600, 600);
        _shareEditView = [[XYShareEditView alloc] initWithFrame:self.xView.bounds];
        [_shareEditView.rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        if (self.text) {
            [_text substringWithRange:NSMakeRange(0, _text.length<=140?_text.length:140)];
            _shareEditView.textView.text = [_text substringWithRange:NSMakeRange(0, _text.length<=140?_text.length:140)];
            _shareEditView.sizeLabel.text = [NSString stringWithFormat:@"%ld/140",_shareEditView.textView.text.length];
        }
        [_shareTypeView pushView:_shareEditView];
    }
    else {
        
        id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                             allowCallback:YES
                                                             authViewStyle:SSAuthViewStyleFullScreenPopup
                                                              viewDelegate:nil
                                                   authManagerViewDelegate:nil];
        
        //在授权页面中添加关注官方微博
        [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                        nil]];
        
        [ShareSDK getUserInfoWithType:_type
                          authOptions:authOptions
                               result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                   if (result)
                                   {
                                       //                                           [item setObject:[userInfo nickname] forKey:@"username"];
                                       //                                           [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
                                   }
                                   NSLog(@"%ld:%@",[error errorCode], [error errorDescription]);
                                   [XYEditManager shardManager].sinaWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo];
                                   [XYEditManager shardManager].tencentWeibo = [ShareSDK hasAuthorizedWithType:ShareTypeTencentWeibo];
                                   [XYEditManager shardManager].netEaseWeibo = [ShareSDK hasAuthorizedWithType:ShareType163Weibo];
                               }];
    }
}
- (void)pushingShareTypeWithButton:(UIButton*)btn {
    NSLog(@"下压");
}


//发表
- (void)clickRightButton:(UIButton*)btn {
  

    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    
    id<ISSCAttachment> image = nil;
    if (self.image) {
        image = [ShareSDK jpegImageWithImage:self.image quality:1];
    }
    else if (self.imageUrl) {
        image = [ShareSDK imageWithUrl:self.imageUrl];
    }
    
    id<ISSContent> publishContent = [ShareSDK content:_shareEditView.textView.text
                                       defaultContent:nil
                                                image:image
                                                title:self.title
                                                  url:self.url
                                          description:self.descriptionString
                                            mediaType:self.mediaType];
    //分享内容
    [ShareSDK oneKeyShareContent:publishContent
                       shareList:@[[NSString stringWithFormat:@"%d",_type]]
                     authOptions:authOptions
                   statusBarTips:YES
                          result:nil];
    [self.navigationController popViewControllerAnimated:NO];

}




- (void)sendTimelineNewsContent
{
//    id<ISSContent> publishContent = [ShareSDK content:_shareEditView.textView.text
//                                       defaultContent:nil
//                                                image:image
//                                                title:self.title
//                                                  url:self.url
//                                          description:self.descriptionString
//                                            mediaType:SSPublishContentMediaTypeText];
//    //分享内容
//    [ShareSDK oneKeyShareContent:publishContent
//                       shareList:@[[NSString stringWithFormat:@"%d",_type]]
//                     authOptions:authOptions
//                   statusBarTips:YES
//                          result:nil];

    
    id<ISSCAttachment> image = nil;
    if (self.image) {
        image = [ShareSDK jpegImageWithImage:self.image quality:1];
    }
    else if (self.imageUrl) {
        image = [ShareSDK imageWithUrl:self.imageUrl];
    }

    NSLog(@"%d\n%@",self.mediaType,self.image);
    id<ISSContent> content = [ShareSDK content:self.text
                                defaultContent:nil
                                         image:image
                                         title:self.title
                                           url:self.url
                                   description:nil
                                     mediaType:self.mediaType];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiTimeline
               authOptions:authOptions
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"知道了"
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];
}




-(void) sendWeixinFriend {


    
    id<ISSContent> content = [ShareSDK content:self.text
                                defaultContent:nil
                                         image:nil
                                         title:nil
                                           url:nil
                                   description:nil
                                     mediaType:SSPublishContentMediaTypeText];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiSession
               authOptions:authOptions
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"知道了"
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];
}
@end
