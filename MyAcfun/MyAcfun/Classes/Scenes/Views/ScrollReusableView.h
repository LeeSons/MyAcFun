//
//  ScrollReusableView.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CBlock) (NSString *option);

@interface ScrollReusableView : UICollectionReusableView

@property(nonatomic, strong)AdScrollView *adView;
@property(nonatomic, strong)NSArray *imageURLArray;
@property(nonatomic, strong)NSArray *imageTitleArray;
@property(nonatomic, copy) CBlock option;
@property(nonatomic, retain) UILabel * lblTitle;

@end
