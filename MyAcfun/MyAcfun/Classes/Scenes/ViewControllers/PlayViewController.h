//
//  PlayViewController.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController
@property(nonatomic, assign) NSInteger playId;
@property(nonatomic, assign) NSInteger playType;
+(PlayViewController *)sharedPlayViewController;

@end
