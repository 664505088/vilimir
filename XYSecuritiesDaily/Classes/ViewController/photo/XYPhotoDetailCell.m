//
//  XYPhotoDetailCell.m
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-6.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import "XYPhotoDetailCell.h"

@implementation XYPhotoDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.transform = CGAffineTransformMakeRotation(1.5707963);
//
        self.imgView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        [self.contentView addSubview:_imgView];
        _imgView.backgroundColor = [UIColor blackColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
        
        self.scrollView = [XYFactory createScrollViewWithFrame:CGRectZero color:nil contentSize:CGSizeZero delegate:nil];
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];

        
        _grayImgView = [XYFactory createImageViewWithFrame:CGRectZero Image:nil];
        UIImage * gray = [UIImage imageNamed:@"photo_background"];
        _grayImgView.image = [gray stretchableImageWithLeftCapWidth:gray.size.width/2 topCapHeight:gray.size.height-5];
        [_scrollView addSubview:_grayImgView];
        
        self.galleryLabel= [XYFactory createLabelWithFrame:CGRectZero Text:@"imgName" Color:[UIColor whiteColor] Font:-1 textAlignment:1];
        [_scrollView addSubview:_galleryLabel];
        _galleryLabel.numberOfLines = 0;
        _galleryLabel.font = [UIFont fontWithName:@"GeezaPro-Bold" size:40];
        
        self.descriptLabel = [XYFactory createLabelWithFrame:CGRectZero Text:@"imgName" Color:[UIColor whiteColor] Font:20 textAlignment:0];
        [_scrollView addSubview:_descriptLabel];
        _descriptLabel.numberOfLines = 0;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [_scrollView addGestureRecognizer:tap];
     
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.height;
    float height = self.bounds.size.width;
    
//    512x768
    self.imgView.frame = CGRectMake(0, 0, width, height);
    _scrollView.frame = CGRectMake(0, 0, width, height-TOOLBAR_HEIGHT);
    
    
    float w = 400;
    CGSize size1 = [_galleryLabel.text sizeWithFont:_galleryLabel.font constrainedToSize:CGSizeMake(w, 400)];
    CGSize size2 = [_descriptLabel.text sizeWithFont:_descriptLabel.font constrainedToSize:CGSizeMake(w, 1000)];
    
    float y = height-TOOLBAR_HEIGHT-size1.height-size2.height-20;
    
    self.galleryLabel.frame = CGRectMake(width-w-20, y, w, size1.height);
    y+=(size1.height+20);
    self.descriptLabel.frame = CGRectMake(width-w-20, y, w, size2.height);
    
    _scrollView.contentSize = CGSizeMake(width, _descriptLabel.frame.origin.y+ _descriptLabel.bounds.size.height+200);
    
    _grayImgView.frame = CGRectMake(0, _galleryLabel.frame.origin.y-30, width, _scrollView.contentSize.height-_galleryLabel.frame.origin.y+30+H_HEIGHT+200);
    
    _scrollView.contentOffset = CGPointMake(0, 30);
}
//
- (void)setPhotoDetail:(MDPhotoDetail *)photoDetail {
    if (photoDetail.img_url) {
        UIImage * image = [UIImage imageNamed:@"image_normal"];
        image = [image createNormalImageWithImageSize:CGSizeMake(H_WIDTH, H_HEIGHT) backgroundColor:[UIColor clearColor] logoSize:CGSizeMake(138, 45)];
        [self.imgView setImageWithURL:[NSURL URLWithString:photoDetail.img_url] placeholderImage:image];
    }
    if (photoDetail.gallery_name) {
        self.galleryLabel.text = photoDetail.gallery_name;
    }
    if (photoDetail.descript) {
        self.descriptLabel.text = photoDetail.descript;
        [self.descriptLabel sizeToFit];
        CGRect frame = self.descriptLabel.frame;
        float height = self.bounds.size.height;
        frame.origin.y = height- frame.size.height-80;
        self.descriptLabel.frame = frame;
    }
    if (photoDetail.comment_count) {
        self.commentCountLabel.text = photoDetail.comment_count;
    }
}

- (void)click:(UITapGestureRecognizer*)gr {

    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:gr.view.tag inSection:0]];
    }
}

@end
