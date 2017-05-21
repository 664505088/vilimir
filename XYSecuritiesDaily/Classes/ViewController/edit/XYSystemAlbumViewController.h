//
//  XYPhotoSelectViewController.h
//  XYSecuritiesDaily
//  选择相册
//  Created by xiwang on 14-7-17.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XYAlbumCell.h"
#import "XYSystemPhotoViewController.h"
//#import "XYSystemAlbumDelegate.h"

@interface XYSystemAlbumViewController : UIViewController
<UIImagePickerControllerDelegate>

@property (nonatomic, assign)id <UIImagePickerControllerDelegate,UINavigationControllerDelegate> delegate;
@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsGroups;

@property (nonatomic, strong) NSMutableArray * selectedImageArray;

@end
