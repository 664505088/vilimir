//
//  XYEditView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-16.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYEditView.h"

@implementation XYEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _switchArray = [[NSMutableArray alloc] init];
        _labelArray = [[NSMutableArray alloc] init];
        _buttonArray = [[NSMutableArray alloc] init];
        //背景
        UIImageView * editBg = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage * image = [UIImage imageNamed:@"edit_bg1"];
        editBg.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self addSubview:editBg];
        
        //设置标题
        UILabel * titleLabel = [XYFactory createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, 55)
                                                          Text:@"设置"
                                                         Color:COLOR_RGB(79, 82, 83)
                                                          Font:28 textAlignment:1];
        [editBg addSubview:titleLabel];
        
        
        [self createWeiboManagerView];//微博管理
        [self createFunctionManagerView];//功能管理
        [self createAboutWeView];//关于我们
//        [self reloadPageData];
    }
    return self;
}



///微博管理
- (void)createWeiboManagerView {
    //组标题
    UILabel * weiboLabel = [XYFactory createLabelWithFrame:CGRectMake(17, 66, 100, 23)
                                                      Text:@"微博管理"
                                                     Color:COLOR_RGB(103, 103, 103)
                                                      Font:20];
    [self addSubview:weiboLabel];
    
    
    ///组背景
    UIImageView * editItemBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 95, 347, 131)];
    UIImage * image1 = [UIImage imageNamed:@"edit_bg2"];
    editItemBg1.image = [image1 stretchableImageWithLeftCapWidth:image1.size.width/2 topCapHeight:image1.size.height/2];
    [self addSubview:editItemBg1];
    
    NSArray * titleArray = @[@"新浪微博",@"腾讯微博",@"网易微博"];
    for (int i=0; i<3; i++) {
        UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(40, 7+i*43.5, 100, 29)
                                                     Text:titleArray[i]
                                                    Color:COLOR_RGB(103, 103, 103)
                                                     Font:20];
        [editItemBg1 addSubview:label];
        
        //图标
        UIImageView * iconView = [XYFactory createImageViewWithFrame:CGRectMake(13, (43-19)/2.0+i*43.5, 19, 19) Image:[NSString stringWithFormat:@"edit_icon_%d",i+1]];
        [editItemBg1 addSubview:iconView];
        
        float x = IOS7?300:270;
        float y = IOS7?95+7:95+8.5;
        UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(x, y+i*43.5, 50, 30)];
        [self addSubview:sw];
        [_switchArray addObject:sw];
        
        //分割线
        UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(4, 44*(i+1), 340, 1) Image:nil];
        line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [editItemBg1 addSubview:line_H];
    
    }
}
//功能管理
- (void)createFunctionManagerView {
    UILabel * functionLabel = [XYFactory createLabelWithFrame:CGRectMake(17, 243, 100, 23)
                                                         Text:@"功能管理"
                                                        Color:COLOR_RGB(103, 103, 103)
                                                         Font:20];
    [self addSubview:functionLabel];
    
    UIImageView * editItemBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 275, 347, 176)];
    UIImage * image2 = [UIImage imageNamed:@"edit_bg2"];
    editItemBg2.image = [image2 stretchableImageWithLeftCapWidth:image2.size.width/2 topCapHeight:image2.size.height/2];
    [self addSubview:editItemBg2];
    
    NSArray * titleArray = @[@"字体大小",@"全屏",@"翻页",@"检查更新"];
    for (int i=0; i<titleArray.count; i++) {
        UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(13, 7+i*43.5, 100, 29)
                                                     Text:titleArray[i]
                                                    Color:COLOR_RGB(103, 103, 103)
                                                     Font:20];
        [editItemBg2 addSubview:label];
        
        if (i==0) {
            UIButton * btn = [XYFactory createButtonWithFrame:CGRectMake(15, 275, 347, 43) Title:nil buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.tag = 0;
            [_buttonArray addObject:btn];
            
            
            NSString * fontSize = [NSString stringWithFormat:@"%@ >",@"大"];
            UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(100, 7, 232, 29) Text:fontSize Color:COLOR_RGB(103, 103, 103) Font:20 textAlignment:2];
            [editItemBg2 addSubview:label];
            
            [_labelArray addObject:label];
        }
        else if (i==1 || i==2) {
            float x = IOS7?300:270;
            float y = IOS7?95+7:95+8.5;
            UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(x, 180+y+i*43.5, 50, 30)];
            [self addSubview:sw];
            [_switchArray addObject:sw];
            
        }else {//检查更新
            UIButton * btn = [XYFactory createButtonWithFrame:CGRectMake(15, 404, 347, 43) Image:nil Image:nil];
            [self addSubview:btn];
            [_buttonArray addObject:btn];
            btn.tag = 1;
            
            
            UILabel * label = [XYFactory createLabelWithFrame:CGRectMake(100, 137.5, 232, 29) Text:nil Color:COLOR_RGB(103, 103, 103) Font:20 textAlignment:2];
            [editItemBg2 addSubview:label];
            [_labelArray addObject:label];
        }
        //分割线
        UIImageView * line_H = [XYFactory createImageViewWithFrame:CGRectMake(4, 44*(i+1), 340, 1) Image:nil];
        line_H.image = [[UIImage imageNamed:@"news_line_H"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [editItemBg2 addSubview:line_H];
    }
}
//关于我们
- (void)createAboutWeView {
    UILabel * aboutLabel = [XYFactory createLabelWithFrame:CGRectMake(17, 466, 100, 23)
                                                      Text:@"关于我们"
                                                     Color:COLOR_RGB(103, 103, 103)
                                                      Font:20];
    [self addSubview:aboutLabel];
    
    UIImageView * editItemBg3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 995/2.0, 347, 89.5)];
    UIImage * image3 = [UIImage imageNamed:@"edit_bg2"];
    editItemBg3.image = [image3 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:image3.size.height/2];
    [self addSubview:editItemBg3];
    
    
    //    button_logout1@2x
    
    UIButton * button = [XYFactory createButtonWithFrame:CGRectMake(17, 610, 345.5, 50) Image:@"edit_button_bg1" Image:@"edit_button_bg2"];
    [self addSubview:button];
    button.tag = 2;
    [_buttonArray addObject:button];
    
    UILabel * logLabel = [XYFactory createLabelWithFrame:button.bounds Text:nil Color:[UIColor whiteColor] Font:20 textAlignment:1];
    [button addSubview:logLabel];
    [_labelArray addObject:logLabel];
}



////刷新页面
//- (void)reloadPageData {
//    for (int i=0; i<_switchArray.count; i++) {
//        UISwitch * sw = [_switchArray objectAtIndex:i];
//        switch (i) {
//            case 0:sw.on = _editManager.sinaWeibo;break;
//            case 1:sw.on = _editManager.tencentWeibo;break;
//            case 2:sw.on = _editManager.netEaseWeibo;break;
//            case 3:sw.on = _editManager.screen;break;
//            case 4:sw.on = _editManager.page;break;
//        }
//    }
//    
//    for (int i=0; i<_labelArray.count; i++) {
//        UILabel * label = [_labelArray objectAtIndex:i];
//        switch (i) {
//            case 0:label.text = [NSString stringWithFormat:@"%@ >",_editManager.fontSize];break;
//            case 1:label.text = [NSString stringWithFormat:@"V%@ >",_editManager.version];break;
//            case 2:{
//                if (_editManager.user.isLogin) {
//                    label.text = @"退出登录";
//                }else {
//                    label.text = @"登录";
//                }
//            };
//        }
//    }
//    
//}



@end
