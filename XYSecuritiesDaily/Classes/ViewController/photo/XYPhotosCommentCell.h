//
//  XYPhotosCommentCell.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-25.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPhotosCommentCell : UITableViewCell

{
    UIImageView *_lineView;
}
@property (nonatomic, strong) UIView    * bgView;

@property (nonatomic, strong) UILabel   * userLabel;
@property (nonatomic, strong) UILabel   * dateLabel;
@property (nonatomic, strong) UILabel   * descriptLabel;


@property (nonatomic, strong) UIView    * fromView;
@property (nonatomic, strong) UILabel   * fromUserLabel;
@property (nonatomic, strong) UILabel   * fromDescriptLabel;

@property (nonatomic) BOOL                isHasFromUser;


+ (float)heightWithAString:(NSString*)aStr
             isHasFromUser:(BOOL)isHas
                   BString:(NSString*)bStr;

- (void)setComment:(MDComment*)comment;

@end
