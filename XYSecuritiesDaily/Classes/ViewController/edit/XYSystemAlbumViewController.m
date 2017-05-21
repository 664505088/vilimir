//
//  XYSystemAlbumViewController.m
//  IHome
//
//  Created by YuanLe on 14-3-12.
//  Copyright (c) 2014年 ihome86. All rights reserved.
//

#import "XYSystemAlbumViewController.h"

//#import "XYFactory.h"
//#import "XYAlbumCell.h"
//#import "XYSystemPhotoViewController.h"
@interface XYSystemAlbumViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation XYSystemAlbumViewController

- (void)dealloc {
    _assetsLibrary = nil;
    _assetsGroups = nil;
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //导航
    self.title = @"选择相册";
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(goBackViewController)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    /* Check sources */
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.assetsLibrary = assetsLibrary;
    
    self.assetsGroups = [NSMutableArray array];
    
    
    _tableView = [XYFactory createTableViewWithFrame:self.view.bounds style:UITableViewStylePlain delegate:self];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self getPhotos];
}

- (void)getPhotos {
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        if(assetsGroup) {
            [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            if(assetsGroup.numberOfAssets > 0) {
                [self.assetsGroups addObject:assetsGroup];
                [_tableView reloadData];
            }
        }
    };
    
    void (^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    // Enumerate Camera Roll
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Photo Stream
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Album
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Event
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupEvent usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Faces
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupFaces usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assetsGroups.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    XYAlbumCell *cell = (XYAlbumCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[XYAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    
    cell.xImageView.image = [UIImage imageWithCGImage:assetsGroup.posterImage];
    cell.xTitleLabel.text = [NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    cell.xSubTitleLabel.text = [NSString stringWithFormat:@"共(%ld)张",assetsGroup.numberOfAssets];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSystemPhotoViewController * vc = [[XYSystemPhotoViewController alloc] init];
    vc.delegate = self.delegate;
    vc.assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - delegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
////    picker
//    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
//        [self.delegate imagePickerController:nil didFinishPickingMediaWithInfo:dic];
//    }
//}
- (void)goBackViewController {
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [self.delegate imagePickerControllerDidCancel:(UIImagePickerController*)self];
    }
}


@end
