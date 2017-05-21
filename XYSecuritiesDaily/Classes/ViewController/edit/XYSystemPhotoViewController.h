//
//  XYSystemPhotoViewController.h
//  IHome
//
//  Created by YuanLe on 14-3-12.
//  Copyright (c) 2014年 ihome86. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XYMorePhotoCell.h"
//#import "XYSystemPhotoDelegate.h"
@interface XYSystemPhotoViewController : UIViewController

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, assign) id <UIImagePickerControllerDelegate,UINavigationControllerDelegate> delegate;
@end
