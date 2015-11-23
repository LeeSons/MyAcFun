//
//  IndexViewCell.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface IndexViewCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *coverImg;
@property(nonatomic, strong)UILabel *lblTitle;
@property(nonatomic, strong)UILabel *lastVideoName;
@property(nonatomic, strong)UILabel *lblViews;
@property(nonatomic, strong)Movie *movie;

@end
