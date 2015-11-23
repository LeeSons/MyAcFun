//
//  GeneralTableViewCell.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "GeneralTableViewCell.h"

@implementation GeneralTableViewCell
#import "Arcitle.h"
#import "Technology.h"
#import "Music.h"
- (void)awakeFromNib {
}

- (void)setArticle:(Arcitle *)article{
    if (_article != article) {
        _article = article;
        _lblTitle.text = article.title;
        [_imgCover sd_setImageWithURL:[NSURL URLWithString:article.user[@"userImg"]]];
    }
}

- (void)setTechnology:(Technology *)technology{
    if (_technology != technology) {
        _technology = technology;
        _lblTitle.text = technology.title;
        [_imgCover sd_setImageWithURL:[NSURL URLWithString:technology.cover]];
    }
}

- (void)setMusic:(Music *)music{
    if (_music != music) {
        _music = music;
        _lblTitle.text = music.title;
        [_imgCover sd_setImageWithURL:[NSURL URLWithString:music.cover]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
