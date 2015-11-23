//
//  ArticleViewCell.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Arcitle.h"
@interface ArticleViewCell : UICollectionViewCell

@property(nonatomic, strong) UILabel * lblTitle;
@property(nonatomic, strong) UILabel * lblDescription;
@property(nonatomic, strong) UILabel * lblUserName;
@property(nonatomic, strong) UILabel * lblViews;
@property(nonatomic, strong) UILabel * lblComments;
@property(nonatomic, strong) UIImageView * userImg;
@property(nonatomic, strong) Arcitle *article;

@end
