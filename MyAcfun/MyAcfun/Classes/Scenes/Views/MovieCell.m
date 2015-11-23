//
//  MovieCell.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    self.backView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
}

- (void)setMovie:(Movie *)movie{
    NSArray *array = [movie.title componentsSeparatedByString:@"】"];
    if ([[array[0] substringToIndex:1] isEqualToString:@"【"]) {
        _lblTitle.text = array[1];
    }else{
        _lblTitle.text = array[0];
    }
    _lblLastVideoName.text = [NSString stringWithFormat:@"更新至:%@",movie.lastVideoName];
    _lblIntro.text = movie.intro;
    CGFloat views = 0;
    if (movie.views >= 10000) {
        views = movie.views / 10000.0;
        _lblViews.text = [NSString stringWithFormat:@"%.2f 万",views];
    }else{
        _lblViews.text = [NSString stringWithFormat:@"%ld",movie.views];
    }
    
    [_img2MoviePic sd_setImageWithURL:[NSURL URLWithString:movie.cover]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
