//
//  PlayViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "PlayViewController.h"
@interface PlayViewController ()<UIWebViewDelegate>
@property(nonatomic, retain) UIWebView *webView;
@end

@implementation PlayViewController
static UIView *loadView = nil;
static PlayViewController *playVC = nil;
+(PlayViewController *)sharedPlayViewController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        playVC = [sb instantiateViewControllerWithIdentifier:@"playingVC"];
        loadView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        loadView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        activity.center = loadView.center;
        [activity startAnimating];
        [loadView addSubview:activity];
        loadView.hidden = YES;
    });
    return playVC;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    loadView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    loadView.hidden = YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPlayView];
    [self.view addSubview:self.webView];
    [self.view addSubview:loadView];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    self.webView = nil;
    [self.webView removeFromSuperview];
}

- (void)loadPlayView{
    NSURLRequest *request = nil;
    if (self.playType == 0) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.acfun.tv/v/ab%ld",self.playId]]];
    }else if (self.playType == 1){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.acfun.tv/a/ac%ld",self.playId]]];
    }else if (self.playType == 2){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.acfun.tv/v/ac%ld",self.playId]]];
    }else if (self.playType == 3){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.acfun.tv/v/ac%ld",self.playId]]];
    }
    [self.webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazyLoad
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -85, self.view.frame.size.width, self.view.frame.size.height + 85)];
        _webView.scrollView.bounces = NO; // 取消弹跳
        _webView.delegate = self;
    }
    return _webView;
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
