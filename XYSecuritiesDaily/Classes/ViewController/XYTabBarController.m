//
//  XYTabBarController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-12.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYMenuCell.h"

#import "XYNewViewController.h"
#import "XYPhotosViewController.h"
#import "XYEpaperViewController.h"
@interface XYTabBarController ()

@end

@implementation XYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //数据库存储服务
    _sqlManager = [XYSqlManager defaultService];
    //存储tabbarviewcontroller的子项
    viewControllers = [[NSMutableArray alloc] init];
    self.menuArray = [[NSMutableArray alloc] init];//菜单
    
    self.tabBar.hidden = YES;
    //更改视图大小位置
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
//            view.hidden = YES;
        }
        else {
            view.frame = CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height);
        }
    }
    
    //从数据库后去菜单信息
    [self getSqlNewsType];
    
    [self createMenuView];//创建菜单视图
}


///创建菜单视图
- (void)createMenuView {
    self.menuTableView = [XYFactory createTableViewWithFrame:CGRectMake(0, 20-STATUS_HEIGHT, MENU_WIDTH, H_HEIGHT)
                                                       style:UITableViewStylePlain
                                                    delegate:self];
    [self.view addSubview:_menuTableView];
    _menuTableView.backgroundColor = COLOR_RGB(38, 43, 45);
    _menuTableView.rowHeight = 57;
    //设置有没有分割线
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MENU_WIDTH, 80)];
    view.backgroundColor = [UIColor clearColor];
    _menuTableView.tableHeaderView = view;
    
    [_menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}



///是否隐藏左侧菜单栏
-  (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    self.menuTableView.hidden = hidesBottomBarWhenPushed;
}




///从本地数据库获取数据
- (void)getSqlNewsType {
    
    //新闻
    
    //获取菜单数组
    NSArray* itemArray = [[XYSqlManager defaultService] selectTableName:TABLE_NewsType parameters:@[@"*"] where:nil];
    if (itemArray.count > 0) {
        for (int i=0; i<itemArray.count; i++) {
            //将菜单数组元素放入menuArray
            MDNewsType*newsType = [itemArray objectAtIndex:i];
            [_menuArray addObject:newsType];

            //创建count个视图控制器
            XYNewViewController * vc = [[XYNewViewController alloc] init];
            UINavigationController * vcNav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.newsType = newsType;
            [viewControllers addObject:vcNav];
        }
    }
    
    
    //图集
    XYPhotosViewController * photoVC = [[XYPhotosViewController alloc] init];
    UINavigationController * photoNav = [[UINavigationController alloc] initWithRootViewController:photoVC];
    [viewControllers addObject:photoNav];
    
    
    XYEpaperViewController * epaperVC = [[XYEpaperViewController alloc] init];
    UINavigationController * epaperNav = [[UINavigationController alloc] initWithRootViewController:epaperVC];
    
    [viewControllers addObject:epaperNav];
    
    //电子报
    
    self.viewControllers = viewControllers;
}












#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuArray.count+2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * IdentifierMenu = @"menu";
    XYMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierMenu];
    if (cell == nil) {
        cell = [[XYMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierMenu];
    }
    if (indexPath.row < _menuArray.count) {
        MDNewsType * newtype = [_menuArray objectAtIndex:indexPath.row];
        if (newtype.name) {
            NSString * text = @"";
            for (int i=0; i<newtype.name.length; i++) {
                NSString * a = [newtype.name substringWithRange:NSMakeRange(i, 1)];
                if (newtype.name.length > 2) {
                    text = [text stringByAppendingFormat:@"%@ ",a];
                }else {
                    text = [text stringByAppendingFormat:@"%@  ",a];
                }
                
            }
            text = [text substringWithRange:NSMakeRange(0, text.length-1)];
            cell.titleLabel.text = text;
        }
        
    }else {
        switch (indexPath.row-_menuArray.count) {
            case 0:cell.titleLabel.text = @"图  集";break;
            case 1:cell.titleLabel.text = @"电 子 报";break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
}


@end
