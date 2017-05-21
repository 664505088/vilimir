//
//  XYEpaperNavigationViewController.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-8-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEpaperNavigationViewController.h"



@implementation XYEpaperNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xView.frame = CGRectMake((H_WIDTH-400)/2, (H_HEIGHT-680)/2, 375, 680);
    
    //时间选择视图背景
    UIImageView * loginBg = [XYFactory createImageViewWithFrame:self.xView.bounds Image:nil];
    UIImage * image = [UIImage imageNamed:@"info_bg1"];
    loginBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [self.xView addSubview:loginBg];
    
    UILabel* titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 10, self.xView.frame.size.width, 35) Text:@"版面导航" Color:nil Font:24 textAlignment:1];
    [self.xView addSubview:titleLabel];
    
    

    
 
    
    
    _tableView = [XYFactory createTableViewWithFrame:CGRectMake(0, 55, self.xView.bounds.size.width, self.xView.bounds.size.height-55) style:UITableViewStylePlain delegate:self];
    [self.xView addSubview:_tableView];
}






#pragma mark - 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(epaperDateWithIndex:)]) {
        [self.delegate epaperDateWithIndex:indexPath.row];
    }
    [self clickBlackPoint];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    MDEpaper * epaper = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = epaper.title;
    return cell;
}



@end
