//
//  MusicViewCell.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"
@interface MusicViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *coverImg;
@property(nonatomic, strong)UILabel *lblTitle;
@property(nonatomic, strong)UILabel *lblViews;
@property(nonatomic, strong)Music *music;

@end
