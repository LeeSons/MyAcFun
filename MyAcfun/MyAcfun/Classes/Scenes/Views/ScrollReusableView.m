//
//  ScrollReusableView.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "ScrollReusableView.h"

@implementation ScrollReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.adView = [[AdScrollView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 240)];
        _adView.PageControlShowStyle = UIPageControlShowStyleCenter;
        _adView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _adView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        [self addSubview:_adView];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, _adView.frame.size.height, 80, 30)];
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = CGRectMake(90, _lblTitle.frame.origin.y + 5, 40, 20);
        [btn setTitle:@"More" forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(tapClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_lblTitle];
        [self addSubview:btn];
        
    }
    return self;
}

- (void)tapClick{
    self.option(_lblTitle.text);
}

- (void)setImageURLArray:(NSArray *)imageURLArray{
    _adView.imageNameArray = imageURLArray;
}
- (void)setImageTitleArray:(NSArray *)imageTitleArray{
    [_adView setAdTitleArray:imageTitleArray withShowStyle:(AdTitleShowStyleLeft)];
}

@end
