//
//  XYLoginViewController.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-3.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYChildViewController.h"

#import "NSString+MD5.h"//md5加密
#import "NSString+isEmail.h"

#import "XYLoginView.h"//登录
#import "XYRegisterView.h"//注册
#import "XYForgetView.h"//忘记密码
#import "XYUserInfoView.h"//用户信息
#import "XYEditInfoView.h"//编辑用户信息
#import "XYEditView.h"//设置

#import "XYCommentViewController.h"//跟帖
#import "XYCollectViewController.h"//收藏
#import "XYMessageViewController.h"//消息

#import "XYPhotoSelectViewController.h"
#import "XYSystemAlbumViewController.h"//选择相册

@interface XYLoginViewController : XYChildViewController
<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    XYEditView      * _editView;
    
    XYLoginView     * _loginView;
    XYRegisterView  * _registerView;
    XYForgetView    * _forgetView;
    
    XYUserInfoView  * _infoView;
    XYEditInfoView  * _editInfoView;
}
@property (nonatomic) BOOL isSelectedEdit;
@property (nonatomic) id<XYLoginViewDelegate>delegate;
@end
