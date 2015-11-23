//
//  ArticleViewCell.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "ArticleViewCell.h"

@implementation ArticleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(_userImg.frame.size.width + 5, 0, frame.size.width - _userImg.frame.size.width - 5, 30)];
        self.lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(_userImg.frame.size.width + 5, 35, _lblTitle.frame.size.width, 40)];
        _lblDescription.font = [UIFont systemFontOfSize:15];
        _lblDescription.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _lblDescription.numberOfLines = 0;
        self.lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(_userImg.frame.size.width + 5, 80, _lblTitle.frame.size.width / 2.0, 30)];
        self.lblViews = [[UILabel alloc] initWithFrame:CGRectMake(110 + _lblUserName.frame.size.width, _lblUserName.frame.origin.y, _lblUserName.frame.size.width / 2.0, 30)];
        _lblViews.textAlignment = NSTextAlignmentCenter;
        _lblViews.font = [UIFont systemFontOfSize:13];
        _lblViews.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _lblUserName.font = [UIFont systemFontOfSize:13];
        _lblUserName.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        self.lblComments = [[UILabel alloc] initWithFrame:CGRectMake(_lblViews.frame.origin.x + _lblViews.frame.size.width, _lblViews.frame.origin.y, _lblViews.frame.size.width, 30)];
        _lblComments.textAlignment = NSTextAlignmentCenter;
        _lblComments.font = [UIFont systemFontOfSize:13];
        _lblComments.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.contentView addSubview:_userImg];
        [self.contentView addSubview:_lblTitle];
        [self.contentView addSubview:_lblDescription];
        [self.contentView addSubview:_lblUserName];
        [self.contentView addSubview:_lblViews];
        [self.contentView addSubview:_lblComments];
        
    }
    return self;
}

- (void)setArticle:(Arcitle *)article{
    [_userImg sd_setImageWithURL:[NSURL URLWithString:article.user[@"userImg"]]];
    _lblTitle.text = article.title;
    _lblDescription.text = article.descriptions;
    _lblUserName.text = [NSString stringWithFormat:@"UP主:%@",article.user[@"username"]];
    
    CGFloat views = 0;
    if (article.views >= 10000) {
        views = article.views / 10000.0;
        _lblViews.text = [NSString stringWithFormat:@"📖%.2f 万",views];
    }else{
        _lblViews.text = [NSString stringWithFormat:@"📖%ld",article.views];
    }

    CGFloat comments = 0;
    if (article.comments >= 10000) {
        comments = article.comments / 10000.0;
        _lblComments.text = [NSString stringWithFormat:@"💬%.2f 万",comments];
    }else{
        _lblComments.text = [NSString stringWithFormat:@"💬%ld",article.comments];
    }
}


@end
