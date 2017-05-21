//
//  XYPhotosDetailViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-5-28.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPhotosDetailViewController.h"

typedef NS_ENUM(NSInteger, XYClickButtonType) {
    XYClickButtonTypeBack  = 0,
    XYClickButtonTypeGenTie     = 1,
    XYClickButtonTypeZhuanFa  = 2,
    XYClickButtonTypeShouCang    = 3,
    XYClickButtonTypeXiaZai
};
@implementation XYPhotosDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.xNavigationBar.hidden = YES;
    self.xView.frame = CGRectMake(0, 0, H_WIDTH, H_HEIGHT);
    self.tableView.frame = self.xView.bounds;
    self.tableView.pagingEnabled = YES;
    


    self.xToolBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    //设置toolBar按钮事件和样式
    for (int i=0; i<self.xToolBar.items.count; i++) {
        UIButton * btn = [self.xToolBar.items objectAtIndex:i];
        
        [btn addTarget:self action:@selector(clickToolBarButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (i==3) {
            _isCollect = [[XYSqlManager defaultService] selectCountWithTableName:TABLE_MyCollect where:[NSString stringWithFormat:@"type=\"Photos\" and idString=\"%@\" ",self.image.idString]];
            if (_isCollect) {
                [btn setImage:[UIImage imageNamed:@"photo_tool42"] forState:UIControlStateNormal];
            }else {
                [btn setImage:[UIImage imageNamed:@"photo_tool41"] forState:UIControlStateNormal];
            }
        }else {
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"photo_tool%d1",i+1]] forState:UIControlStateNormal];
        }
    }
    
    
    //显示页码
    _pageControl = [[XYPageIndexControl alloc] initWithFrame:CGRectMake(460, self.xToolBar.bounds.size.height-42.5, 200, 30)];
    [self.xToolBar addSubview:_pageControl];
    [_pageControl setindex:0 Count:0];
    
    
    ///显示跟帖数
    _genTieButotn = [XYFactory createButtonWithFrame:CGRectMake(920, self.xToolBar.bounds.size.height-42, 56, 23) Title:@"0跟帖" backGroundColor:[UIColor redColor] buttonWithType:UIButtonTypeCustom];
    [self.xToolBar addSubview:_genTieButotn];
    _genTieButotn.tag = 5;
    [_genTieButotn addTarget:self action:@selector(clickToolBarButton:) forControlEvents:UIControlEventTouchUpInside];
    _genTieButotn.hidden = YES;
    
    
    if (self.imageListArray != nil) {
        _refreshTableHeadView = [[XYRefreshTableHeadView alloc] initWithFrame:CGRectMake(0, -self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        _refreshTableFootView = [[XYRefreshTableFootView alloc] initWithFrame:CGRectMake(0, self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        
        [self.tableView addSubview:_refreshTableHeadView];
        [self.tableView addSubview:_refreshTableFootView];
    }

    
    
    //获取详情内容
    self.pageIndex = 1;
    [self getPhotoDetail];
}



#pragma mark - 点击事件
///点击返回/评论/分享/收藏/下载
- (void)clickToolBarButton:(UIButton*)btn {
    //返回
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (_pageControl.index > 0 && _pageControl.index <= self.dataArray.count) {
        self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        //获取当前显示的图片model
        MDPhotoDetail * photoDetail = [self.dataArray objectAtIndex:_pageControl.index-1];
        
        //评论
        if (btn.tag == 1) {//跟帖
            XYPCEditViewController * vc = [[XYPCEditViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.image = self.image;
            [self presentViewController:nav animated:NO completion:nil];
        }
        //分享
        else if (btn.tag == 2) {//分享
            NSString * path = [NSString stringWithFormat:@"%@/Library/Caches/ImageCache/%@",NSHomeDirectory(),[photoDetail.img_url md5]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
                
                XYShareViewController * vc = [[XYShareViewController alloc] init];
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
                vc.image = image;
                
                if (photoDetail.gallery_name) {
                    vc.title = photoDetail.gallery_name;
                }
                if (photoDetail.descript) {
                    vc.descriptionString = photoDetail.descript;
                }
                if (photoDetail.img_url) {
                    vc.url = photoDetail.img_url;
                }
                vc.text = [NSString stringWithFormat:@"#证券日报#图集#%@,与您分享下,图片地址:%@",vc.title,vc.url];
                vc.mediaType = SSPublishContentMediaTypeImage;
                [self presentViewController:nav animated:NO completion:nil];
            }else {
                [SVProgressHUD showErrorWithStatus:@"正在加载图片,请稍后再试" duration:1];
            }
        }
        //收藏
        else if (btn.tag == 3) {//收藏
            if (_isCollect) {
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功" duration:1];
                if ([[XYSqlManager defaultService] deleteFromTableName:@"MyCollect" where:[NSString stringWithFormat:@"type=\"Photos\" and idString=\"%@\" ",self.image.idString]]) {
                    _isCollect = NO;
                    [btn setImage:[UIImage imageNamed:@"photo_tool41"] forState:UIControlStateNormal];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"取消收藏失败" duration:1];
                }
                
            }
            else {
                MDCollect * collect = [[MDCollect alloc] initWithItem:self.image];
                NSDateFormatter * fm = [[NSDateFormatter alloc] init];
                fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                collect.create_date = [fm stringFromDate:[NSDate date]];
                if ([[XYSqlManager defaultService] insertItem:collect]) {
                    _isCollect = YES;
                    [btn setImage:[UIImage imageNamed:@"photo_tool42"] forState:UIControlStateNormal];
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功" duration:1];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"收藏失败" duration:1];
                }
            }
        }
        //下载
        else if (btn.tag == 4) {//下载图片
            NSString * path = [NSString stringWithFormat:@"%@/Library/Caches/ImageCache/%@",NSHomeDirectory(),[photoDetail.img_url md5]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [SVProgressHUD showWithStatus:@"正在下载"];
                UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }else {
                [SVProgressHUD showErrorWithStatus:@"正在加载图片,请稍后再试" duration:1];
            }
        }
        //跟帖
        else if (btn.tag == 5) {//跟帖
            XYPhotoCommentViewController * vc = [[XYPhotoCommentViewController alloc] init];
            vc.image = self.image;
            vc.photoDetail = photoDetail;
            if (photoDetail.comment_count) {
                vc.pageCount = ([photoDetail.comment_count intValue]+14)/15;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"没有找到该图集" duration:1.5f];
    }
}



- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void*)contextInfo {
    if (error == nil) {
        [SVProgressHUD dismissWithSuccess:@"图片已保存到相册中"];
    }
    else [SVProgressHUD dismissWithError:@"图片保存失败"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return;
    ///隐藏和现实toolbar和标题
    XYPhotoDetailCell * cell = (XYPhotoDetailCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    int alpha = cell.scrollView.hidden?1:0;
    if (alpha) {
        cell.scrollView.hidden = NO;
        self.xToolBar.hidden = NO;
    }
    [UIView animateWithDuration:0.8 animations:^{
        if (alpha) {
            cell.imageView.transform = CGAffineTransformIdentity;
        }
        cell.scrollView.alpha = alpha;
        self.xToolBar.alpha = alpha;
    } completion:^(BOOL finished) {
        if (!alpha && finished) {
            cell.scrollView.hidden = YES;
            self.xToolBar.hidden = YES;
        }
    }];
}




#pragma mark - 解析
///获取图集->图片列表(net/sql)
- (void)getPhotoDetail {
    _isLoading = YES;
    if (self.netStatus) {  //有网络
        [self getNetPhotoDetailList];
    }else {  //无网络
        [self getSqlPhotoDetailWithNetStatus:NO];
    }
}

//网络获取
- (void)getNetPhotoDetailList {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"pad_1.4",@"mode",
                                 @"2",@"company_id",
                                 [NSString stringWithFormat:@"%d",self.pageIndex],@"page",
                                 @"1024",@"img_width",
                                 self.image.idString,@"id",nil];
    
    [SVProgressHUD showWithStatus:@"正在加载数据"];

    [[RequestService defaultService] getRequestWithParameters:parameters success:^(GDataXMLElement *root) {
        NSArray * imageList = [[[root elementsForName:@"img_list"] firstObject] elementsForName:@"img"];
        
        
        //删除sql页面数据
        if (self.pageIndex== 1) {
            [self.sqlManager deleteFromTableName:@"PhotoDetail" where:[NSString stringWithFormat:@"idString=\"%@\"",self.image.idString]];
        }else {
            [self.sqlManager deleteFromTableName:@"PhotoDetail" where:[NSString stringWithFormat:@"page=\"%d\" and idString=\"%@\"",self.pageIndex,self.image.idString]];
        }
        
        
        //插入sql
        for (int i=0; i<imageList.count; i++) {
            GDataXMLElement * element = [imageList objectAtIndex:i];
            MDPhotoDetail * photoDetail = [[MDPhotoDetail alloc] initWithElement:element];
            photoDetail.idString = self.image.idString;
            photoDetail.img_width = @"1024";
            photoDetail.page = [NSString stringWithFormat:@"%d",self.pageIndex];
            [self.sqlManager insertItem:photoDetail];
        }
        NSString * comment_count = [[[root elementsForName:@"comment_count"] firstObject] stringValue];
        if (comment_count) {
            _genTieButotn.hidden = NO;
            NSString * title = [NSString stringWithFormat:@"%@跟帖",comment_count];
            [_genTieButotn setTitle:title forState:UIControlStateNormal];
            CGSize size = [title sizeWithFont:_genTieButotn.titleLabel.font constrainedToSize:CGSizeMake(1000, 30)];
            _genTieButotn.frame = CGRectMake(H_WIDTH-45-size.width, self.xToolBar.bounds.size.height-size.height-15, size.width+5, size.height+5);
        }else {
            _genTieButotn.hidden = YES;
        }
        
        //查询sql
        [self getSqlPhotoDetailWithNetStatus:YES];
        
        ///获取图集的总页数
    } falid:^(NSString *errorMsg) {//查询sql
        [self getSqlPhotoDetailWithNetStatus:NO];
    }];
}
//数据库获取数据
- (void)getSqlPhotoDetailWithNetStatus:(BOOL)status {
    ///获取第page页数据
    NSArray * arr = [self.sqlManager selectTableName:TABLE_PhotoDetail parameters:@[@"*"] where:[NSString stringWithFormat:@"page=\"%d\" and idString=\"%@\"",self.pageIndex,self.image.idString]];
    if (self.pageIndex == 1) {//首页删除数据源
        [self.dataArray removeAllObjects];
    }
    
    if (arr.count > 0) {
        [self.dataArray addObjectsFromArray:arr];
        
        if (!status) {//如果没有网络时候,提示使用缓存
            [SVProgressHUD dismissWithError:REQUEST_MESSAGE_CACHE];
        }else {
            [SVProgressHUD dismiss];
        }
    }else {
        if (status) {
            [SVProgressHUD dismissWithError:REQUEST_MESSAGE_NONE];
        }else {
            [SVProgressHUD dismissWithError:REQUEST_MESSAGE_FAIL];
        }
    }
    if (status) {
        [self reloadEnd];
    }else {
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
    }
}




- (void)reloadEnd {
    
    [self.tableView reloadData];
    
    if (self.pageIndex == 1) {//如果获取首页信息->转到顶
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
    _isLoading = NO;
    int page = [self indexOfmoveTableView]+1;
    if (page > 0 && page <= self.dataArray.count) {
        [_pageControl setindex:page Count:(int)self.dataArray.count];
    }
    
    float bcw = self.tableView.contentSize.height;
    if (bcw == 0) {
        bcw = self.tableView.bounds.size.height;
        if (self.dataArray.count==0) {
            [_pageControl setindex:0 Count:(int)self.dataArray.count];
        }
    }
    CGRect frame = _refreshTableFootView.frame;
    frame.origin.y = bcw;
    _refreshTableFootView.frame = frame;
    
}
///计算当前页码
- (int)indexOfmoveTableView {
    float bcw = self.tableView.contentSize.height;
    float bw = self.tableView.bounds.size.height;
    float by = self.tableView.contentOffset.y;
    if (bcw == 0) {
        bcw = self.tableView.bounds.size.height;
    }
    if (by < 0) {
        return -1;
    }else {
        if (by > bcw-bw) {
            return bcw/bw;
        }else {
            return (by+bw/2)/bw;
        }
        return -1;
    }
}





#pragma mark - tableViewdelgate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return H_WIDTH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPhotoDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYPhotoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    MDPhotoDetail * detail = [self.dataArray objectAtIndex:indexPath.row];
    [cell setPhotoDetail:detail];
    cell.scrollView.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}











- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //更改页码(以及位置)
    int page = [self indexOfmoveTableView]+1;
    if (page > 0 && page <= self.dataArray.count) {
        [_pageControl setindex:page Count:(int)self.dataArray.count];
    }
    if (!_isLoading) {
        [_refreshTableHeadView stopWithTitle:@"松开后加载上一图集"];
        if (self.pageIndex+1 <= self.pageCount && self.pageIndex+1>0) {
            [_refreshTableFootView stopWithTitle:@"松开后加载下一页"];
        }
        else {
            [_refreshTableFootView stopWithTitle:@"松开后加载下一图集"];
        }
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        NSInteger page = [self indexOfmoveTableView];
        NSLog(@"%ld/%ld",page,self.dataArray.count);
        if (!_isLoading) {
            if (self.imageListArray) {
                //滑动切换到上一图集
                if (page < 0) {
                    NSInteger index = [self.imageListArray indexOfObject:self.image];
                    index--;
                    
                    
                    if (index < self.imageListArray.count && index >= 0) {
                        NSLog(@"上一图集:%ld/%ld",index,self.imageListArray.count);
                        self.image = [self.imageListArray objectAtIndex:index];
                        self.pageIndex = 1;
                        [self getPhotoDetail];
                        [_refreshTableHeadView startWithScrollView:scrollView];
                    }
                    else {
                        if (self.netStatus) {
                            [SVProgressHUD showErrorWithStatus:@"已经到头了" duration:1.5f];
                        }
                        else {
                            [SVProgressHUD showErrorWithStatus:@"已经到头了" duration:1.5f];
                        }
                        _isLoading = YES;
                        //延迟0.5秒
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*0.5), dispatch_get_current_queue(), ^{
                            _isLoading = NO;
                        });
                    }
                }
                //滑动切换到下一图集
                else if (page >= self.dataArray.count){
                    if (self.pageIndex+1 <= self.pageCount && self.pageIndex+1>0) {
                        NSLog(@"下一页");
                        self.pageIndex++;
                        [self getPhotoDetail];
                        [_refreshTableFootView startWithScrollView:scrollView];
                    }
                    else {
                        NSInteger index = [self.imageListArray indexOfObject:self.image];
                        index++;
                        
                        if (index < self.imageListArray.count && index > 0) {
                            NSLog(@"下一图集:%ld/%ld",index,self.imageListArray.count);
                            self.image = [self.imageListArray objectAtIndex:index];
                            self.pageIndex = 1;
                            [self getPhotoDetail];
                            
                            [_refreshTableFootView startWithScrollView:scrollView];
                        }else {
                            if (self.netStatus) {
                                [SVProgressHUD showErrorWithStatus:@"没有更多图集了" duration:1.5f];
                            }else {
                                [SVProgressHUD showErrorWithStatus:@"没有更多缓存图集了" duration:1.5f];
                            }
                            
                            //延迟0.5秒
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*0.5), dispatch_get_current_queue(), ^{
                                _isLoading = NO;
                            });
                        }
                    }
                }
            }
        }
    }
}

@end
