//
//  MovieCell.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img2MoviePic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLastVideoName;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblViews;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property(nonatomic, strong) Movie * movie;

@end
