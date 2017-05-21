//
//  XYCommentCell.h
//  XYSecuritiesDaily
//
//  Created by xiwang on 14-6-13.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDComment.h"

#define MDCOMMENT_FONT_MY_descript [UIFont systemFontOfSize:22]
#define MDCOMMENT_FONT_MY_title [UIFont systemFontOfSize:23]
#define MDCOMMENT_FONT_MY_fromUser [UIFont systemFontOfSize:25]
#define MDCOMMENT_FONT_MY_fromDescript [UIFont systemFontOfSize:22]


@interface XYCommentCell : UITableViewCell

{
    UIImageView *_lineView;
}
@property (nonatomic, strong) UIView    * bgView;
@property (nonatomic, strong) UILabel   * dateLabel;
@property (nonatomic, strong) UILabel   * descriptLabel;
@property (nonatomic, strong) UILabel   * statusLabel;

@property (nonatomic, strong) UIView    * fromView;
@property (nonatomic, strong) UILabel   * fromUserLabel;
@property (nonatomic, strong) UILabel   * fromDescriptLabel;

@property (nonatomic, strong) UILabel   * titleLabel;

@property (nonatomic) BOOL                isHasFromUser;

+ (float)heightWithDescript:(NSString *)descript
                      title:(NSString *)title
              isHasFromUser:(BOOL)isHas
                  from_user:(NSString *)from_user
              from_descript:(NSString *)from_descript;

- (void)setComment:(MDComment*)comment;
@end
