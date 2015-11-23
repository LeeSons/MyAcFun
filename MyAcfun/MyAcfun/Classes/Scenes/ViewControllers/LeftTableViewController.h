//
//  LeftTableViewController.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBlock)(void);
@interface LeftTableViewController : UITableViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property(nonatomic, copy)MyBlock callBackToClose;
@end
