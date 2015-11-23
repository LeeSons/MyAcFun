//
//  WelcomeViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "WelcomeViewController.h"
#import "IndexViewController.h"
#import "LeftTableViewController.h"
#import "AppDelegate.h"
#import "NetStataHelper.h"
@interface WelcomeViewController ()
@property(nonatomic, strong)ICSDrawerController *indexDrow;
@property(nonatomic, strong)UIAlertController *alert;
@end

@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已断开连接，请检查网络。" preferredStyle:(UIAlertControllerStyleAlert)];
    LCPAnimation *lcpanima = [LCPAnimation new];
    [lcpanima setViewAnimationWithAnimationType:Push Duration:1 View:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkNetState];
    });
}

- (void)checkNetState{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络状态改变时的回调
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            if (self.isViewLoaded && self.view.window) {
                
                [self presentViewController:_alert animated:YES completion:nil];
            }else{
                [self.indexDrow presentViewController:_alert animated:YES completion:nil];
            }
        }else{
            [_alert dismissViewControllerAnimated:YES completion:nil];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self gogo];
            });
        }
    }];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)gogo{
    LCPAnimation *lcpAnimation = [LCPAnimation new];
    [lcpAnimation setViewAnimationWithAnimationType:RippleEffect Duration:3 View:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        IndexViewController *index = [sb instantiateViewControllerWithIdentifier:@"index"];
        LeftTableViewController *left = [[LeftTableViewController alloc] initWithStyle:(UITableViewStylePlain)];
        left.callBackToClose = ^(){
            [_indexDrow close];
        };
        self.indexDrow = [[ICSDrawerController alloc] initWithLeftViewController:left centerViewController:index];
        _indexDrow.title = @"首页";
        _indexDrow.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HAMBURGER_MENU_21.333333333333px_1162343_easyicon.net.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(openDrow:)];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_indexDrow];
        nav.navigationBar.barTintColor = [UIColor colorWithRed:54 / 255.0 green:123 / 255.0 blue:210 / 255.0 alpha:1];
        nav.navigationBar.tintColor = [UIColor whiteColor];
        nav.navigationBar.translucent = NO;
        nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self presentViewController:nav animated:YES completion:nil];
    });
}

- (void)openDrow:(UIBarButtonItem *)sender{
    [_indexDrow open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
