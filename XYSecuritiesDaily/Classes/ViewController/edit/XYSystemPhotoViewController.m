//
//  XYSystemPhotoViewController.m
//  IHome
//
//  Created by YuanLe on 14-3-12.
//  Copyright (c) 2014年 ihome86. All rights reserved.
//

#import "XYSystemPhotoViewController.h"
#import "XYFactory.h"
#import "TMQuiltView.h"
#import "XYMorePhotoCell.h"
@class XYSystemAlbumViewController;
@interface XYSystemPhotoViewController ()<TMQuiltViewDelegate,TMQuiltViewDataSource>
{
    TMQuiltView * _xQuiltView;
    NSMutableArray * _xDataArray;
    NSMutableArray * _deleteArray;
}
@end

@implementation XYSystemPhotoViewController

- (void)dealloc {
    _xDataArray = nil;
//    _delegate = nil;
    _xQuiltView = nil;
//    _delegate = nil;
    _assetsGroup = nil;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航
//	[self setNavagationBarView:nil];
//    [self setNavLeftBackBtn:nil];
//    UIButton * _rightBtn = [self setRightBtn:@"完成"];
//    [_rightBtn addTarget:self
//                  action:@selector(btnClickDone)
//        forControlEvents:UIControlEventTouchUpInside];
    self.title = @"选择照片";
    
    _xDataArray = [[NSMutableArray alloc] init];
    _deleteArray = [[NSMutableArray alloc] init];
    
    
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [_xDataArray addObject:result];
            [_deleteArray addObject:@"0"];
        }
    }];
    _xQuiltView = [[TMQuiltView  alloc] initWithFrame:CGRectMake(0, 0, H_WIDTH, H_HEIGHT)];
    _xQuiltView.delegate = self;
    _xQuiltView.dataSource = self;
    _xQuiltView.backgroundColor = [UIColor  clearColor];
    [self.view  addSubview:_xQuiltView];
    [_xQuiltView  reloadData];
}






#pragma mark - dataSouth
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return _xDataArray.count;
}
- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath*)indexPath {

    XYMorePhotoCell * cell = (XYMorePhotoCell*)[quiltView dequeueReusableCellWithReuseIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYMorePhotoCell alloc] initWithReuseIdentifier:@"ID"];
    }
    ALAsset *asset = [_xDataArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    return cell;
}

#pragma mark - delegate
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
    ALAsset * asset = [_xDataArray objectAtIndex:indexPath.row];
    UIImage * image = [UIImage imageWithCGImage:[[asset  defaultRepresentation]fullScreenImage]];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:image,@"UIImagePickerControllerOriginalImage", nil];
    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
        [self.delegate imagePickerController:(UIImagePickerController*)self didFinishPickingMediaWithInfo:dic];
    }
}


- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return 6;
}



// Must return the height of the requested cell
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    return H_WIDTH/6;
}



@end
