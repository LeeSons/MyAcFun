//
//  IndexViewCell.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "IndexViewCell.h"

@implementation IndexViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height / 3.0 * 2)];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _coverImg.frame.size.width, 20)];
        topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.lblViews = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 120, 16)];
        _lblViews.font = [UIFont systemFontOfSize:15];
        _lblViews.textColor = [UIColor whiteColor];
        _lblViews.text = @"12.3万";
        [topView addSubview:_lblViews];
        [_coverImg addSubview:topView];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5 + _coverImg.frame.size.height, _coverImg.frame.size.width, frame.size.height / 3.0 - 10)];
        _lblTitle.font = [UIFont systemFontOfSize:14];
        _lblTitle.numberOfLines = 2;
        [self.contentView addSubview:_coverImg];
        [self.contentView addSubview:_lblTitle];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setMovie:(Movie *)movie{
    NSArray *array = [movie.title componentsSeparatedByString:@"】"];
    if ([[array[0] substringToIndex:1] isEqualToString:@"【"]) {
        _lblTitle.text = [NSString stringWithFormat:@"%@【%@】",array[1],movie.lastVideoName];
    }else{
        _lblTitle.text = [NSString stringWithFormat:@"%@【%@】",array[0],movie.lastVideoName];
    }
    CGFloat views = 0;
    if (movie.views >= 10000) {
        views = movie.views / 10000.0;
        _lblViews.text = [NSString stringWithFormat:@"📺%.2f 万",views];
    }else{
        _lblViews.text = [NSString stringWithFormat:@"📺%ld",movie.views];
    }
    [_coverImg sd_setImageWithURL:[NSURL URLWithString:movie.cover]];
}

@end
