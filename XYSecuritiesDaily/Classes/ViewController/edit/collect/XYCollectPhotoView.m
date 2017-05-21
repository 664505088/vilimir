//
//  XYCollectPhotoView.m
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYCollectPhotoView.h"

@implementation XYCollectPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.waterView = [[TMQuiltView  alloc] initWithFrame:self.bounds];
        _waterView.delegate = self;
        _waterView.dataSource = self;
        _waterView.backgroundColor = [UIColor clearColor];
        [self addSubview:_waterView];
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - TMQuiltView DataSource
//返回数据条数
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView
{
    return _dataArray.count;
}

- (TMQuiltViewCell  *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString  *identifierStr = @"photoCollectID";
    XYQuiltCollectCell  *cell = (XYQuiltCollectCell*)[quiltView  dequeueReusableCellWithReuseIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[XYQuiltCollectCell  alloc] initWithReuseIdentifier:identifierStr];
    }
    MDImage * image = [_dataArray objectAtIndex:indexPath.row];
    if (image.listName) {
        cell.titleLabel.text = image.listName.length>8?[image.listName substringToIndex:8]:image.listName;
    }
    [cell.imageView setImageWithURL:[NSURL URLWithString:image.img_url]];
    return cell;
}
//点击某cell时调用
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataArray.count) {
        if ([self.delegate respondsToSelector:@selector(quiltView:didSelectCellAtIndexPath:)]) {
            [self.delegate quiltView:quiltView didSelectCellAtIndexPath:indexPath];
        }
    }
}


#pragma mark -TMQuiltView Delegate
//返回几列
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView
{
    return 4;
}
//返回某cell高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    //    200xheight
    if (indexPath.row < _dataArray.count) {
        MDImage * image = [_dataArray objectAtIndex:indexPath.row];
        float width = [image.width floatValue];
        float height = [image.height floatValue];
        height = height>0?height:100;
        width = width>0?width:200;
        return 200./(width/height)+70;
    }
    return 200./(100/200.)+70;
}



@end
