//
//  XYCollectViewController.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-10.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYCollectViewController.h"

@interface XYCollectViewController ()

@end

@implementation XYCollectViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取数据
    [self getSqlCollectNews];
    [self getSqlCollectPhotos];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIButton* btn in self.xNavigationBar.items) {
        btn.hidden = YES;
    }
    
    
    _lineArray = [[NSMutableArray alloc] init];//存线
    for (int i=0; i<self.xToolBar.items.count; i++) {
        UIButton * btn = [self.xToolBar.items objectAtIndex:i];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"news_tool11"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"news_tool12"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            btn.hidden = YES;
        }
    }
    self.xNavigationBar.frame = CGRectMake(0, 0, H_WIDTH, NAVIGATION_HEIGHT+40);
    self.xView.frame = CGRectMake(0, NAVIGATION_HEIGHT+40, H_WIDTH*2, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    
    
    
    //创建新闻/图集底部容器
//    _scrollView = [XYFactory createScrollViewWithFrame:self.xView.bounds
//                                                 color:nil
//                                           contentSize:CGSizeMake(H_WIDTH*2, self.xView.bounds.size.height-100-STATUS_HEIGHT)
//                                              delegate:nil];
//    [self.xView addSubview:_scrollView];
//    _scrollView.pagingEnabled = YES;
//    _scrollView.scrollEnabled = NO;
    
    
  
     
    //我的收藏 标题
    UILabel * myCollectLabel = [XYFactory createLabelWithFrame:CGRectMake(50, 15+STATUS_HEIGHT, 180, 42) Text:@"我 的 收 藏" Font:30];
    [self.xNavigationBar addSubview:myCollectLabel];
    
 
    //选项卡
    _collectTypeView = [[XYCollectTypeView alloc] initWithFrame:CGRectMake(50, 56+STATUS_HEIGHT, 160, 40) titles:@[@"文章",@"图片"]];
    _collectTypeView.gap = 65;//中间间隔大小
    [self.xNavigationBar addSubview:_collectTypeView];
    [_collectTypeView addTarget:self action:@selector(clickSelectCollectType:)];
    

    
    //创建2视图
    [self createNewsTable];
    [self createPhotosTable];
    
    
 
}

- (void)createNewsTable {
    self.tableView.transform = CGAffineTransformIdentity;
    self.tableView.frame = CGRectMake(0, 0, H_WIDTH, self.xView.bounds.size.height);
    
    self.xRefreshFailView.frame = self.tableView.bounds;
}

- (void)createPhotosTable {
    self.xRefreshFailView2 = [[XYRefreshView alloc] initWithFrame:CGRectMake(H_WIDTH+20, 0, H_WIDTH-40, self.xView.bounds.size.height)];
    [self.xView addSubview:_xRefreshFailView2];
    
    _photoView = [[XYCollectPhotoView alloc] initWithFrame:_xRefreshFailView2.frame];
    [self.xView addSubview:_photoView];
    _photoView.delegate = self;
    _photoView.waterView.bounces = NO;

    for (int i=0; i<3; i++) {
        UIImageView * lineV = [XYFactory createImageViewWithFrame:CGRectMake(H_WIDTH+20+246*(i+1), 0, 1, _photoView.bounds.size.height) Image:nil];
        lineV.image = [[UIImage imageNamed:@"line_V"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self.xView addSubview:lineV];
        [_lineArray addObject:lineV];
    }
}













#pragma mark - 点击
///点击返回
- (void)clickbackButton:(UIButton*)btn {
    [self.navigationController popViewControllerAnimated:YES];
}
///点击选项卡
- (void)clickSelectCollectType:(XYCollectTypeView*)collectTypeView {
    [UIView animateWithDuration:0.5 animations:^{
        self.xView.frame = CGRectMake(-collectTypeView.selectedIndex*H_WIDTH, NAVIGATION_HEIGHT+40, H_WIDTH*2, H_HEIGHT-NAVIGATION_HEIGHT-40-TOOLBAR_HEIGHT);
    }];
}







#pragma mark - 解析
- (void)getSqlCollectNews {
    NSArray * collects = [self.sqlManager selectTableName:TABLE_MyCollect parameters:@[@"*"] where:@"type=\"News\""];
    [self.dataArray removeAllObjects];
    if (collects.count > 0) {
        for (int i=0; i<collects.count; i++) {
            MDCollect * collect = [collects objectAtIndex:i];
//            MDNews * news = [collect exportObjectWithType:@"News"];
            [self.dataArray addObject:collect];
        }
        [self.tableView reloadData];
        self.xRefreshFailView.hidden = YES;
    }
    else {
        [self.xRefreshFailView showRefreshViewIsOK:NO
                                              title:@"亲,您还没有收藏\"文章\"哦" subTitle:@""];
        self.tableView.hidden = YES;
    }
    
}

- (void)getSqlCollectPhotos {
    NSArray * collects = [self.sqlManager selectTableName:@"MyCollect" parameters:@[@"*"] where:@"type=\"Photos\""];
    [_photoView.dataArray removeAllObjects];
    if (collects.count > 0) {
        for (int i=0; i<collects.count; i++) {
            MDCollect * collect = [collects objectAtIndex:i];
            MDImage * image = [collect exportObjectWithType:@"Photos"];
            [_photoView.dataArray addObject:image];
        }
        [_photoView.waterView reloadData];
        _xRefreshFailView2.hidden = YES;
    }
    else {
        [self.xRefreshFailView2 showRefreshViewIsOK:NO
                                              title:@"亲,您还没有收藏\"图集\"哦" subTitle:@""];
        _photoView.hidden = YES;
    }
    
}




#pragma mark - 点击某个图集
//点击某cell时调用
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    XYPhotosDetailViewController * vc  =[[XYPhotosDetailViewController alloc] init];
    MDImage * image = [_photoView.dataArray objectAtIndex:indexPath.row];
    vc.image = image;
    vc.imageListArray = _photoView.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYNewsCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[XYNewsCollectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    [cell setCollect:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <self.dataArray.count) {
        XYDetailViewController * vc  =[[XYDetailViewController alloc] init];
        MDCollect * collect = [self.dataArray objectAtIndex:indexPath.row];
        MDNews * news = [collect exportObjectWithType:@"News"];
        vc.news = news;
        vc.hideEditItem = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!IOS7) {//如果版本低于ios7
        XYNewsCollectCell * cell = (XYNewsCollectCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.leftMove = YES;
//        CGRect frame = cell.bgView.frame;
//        frame.origin.x = -80;
//        [UIView animateWithDuration:0.25 animations:^{
//            cell.bgView.frame = frame;
//            NSLog(@"左移动");
//        } completion:nil];
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!IOS7) {//如果小于ios7
        
//        NSLog(@"右移动");
        XYNewsCollectCell * cell = (XYNewsCollectCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.leftMove = NO;
//        CGRect frame = cell.contentView.frame;
//        frame.origin.x = 0;
//        [UIView animateWithDuration:0.25 animations:^{
//            cell.bgView.frame = frame;
//        } completion:nil];
    }
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (!IOS7) {//如果小于ios7
            XYNewsCollectCell * cell = (XYNewsCollectCell*)[tableView cellForRowAtIndexPath:indexPath];
            CGRect frame = cell.contentView.frame;
            frame.origin.x = 0;
            [UIView animateWithDuration:0.25 animations:^{
                cell.bgView.frame = frame;
            } completion:nil];
        }
        MDNews * news = [self.dataArray objectAtIndex:indexPath.row];
        
        if ([[XYSqlManager defaultService] deleteFromTableName:@"MyCollect" where:[NSString stringWithFormat:@"type=\"News\" and column_id=\"%@\" and idString=\"%@\"",news.column_id,news.idString]]) {
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        if (self.dataArray.count==0) {
            [self.xRefreshFailView showRefreshViewIsOK:NO
                                                 title:@"亲,您还没有收藏\"文章\"哦" subTitle:@""];
            self.tableView.hidden = YES;
        }
    }
}

















////移动是调用
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == _waterView) {
//        float y = _waterView.contentOffset.y;
//        float lineY = 0;
//        if (y<=0) {
//            lineY = -y;
//        }
//        for (UIImageView * line in _lineArray) {
//            CGRect frame = line.frame;
//            frame.origin.y = lineY;
//            line.frame = frame;
//            
//        }
//    }
//}



@end
