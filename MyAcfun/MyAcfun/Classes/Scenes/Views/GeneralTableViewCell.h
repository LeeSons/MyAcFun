//
//  GeneralTableViewCell.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Arcitle.h"
#import "Technology.h"
#import "Music.h"
@interface GeneralTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgCover;

@property (nonatomic, strong) Arcitle *article;
@property(nonatomic, strong) Technology * technology;
@property(nonatomic, strong) Music * music;


@end
