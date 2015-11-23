//
//  LeftViewCell.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

- (void)awakeFromNib {
    _imgTypeDes.layer.masksToBounds = YES;
    _imgTypeDes.layer.cornerRadius = _imgTypeDes.frame.size.width / 2.0f;
    _lblMenuType.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
