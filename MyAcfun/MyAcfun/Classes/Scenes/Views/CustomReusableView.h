//
//  CustomReusableView.h
//  UI21_UICollectionView
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 MyOClesson.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CBlock) (NSString *option);
@interface CustomReusableView : UICollectionReusableView
@property(nonatomic, copy) CBlock option;
@property(nonatomic, retain) UILabel * lblTitle;
@end
