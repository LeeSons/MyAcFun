//
//  CustomReusableView.m
//  UI21_UICollectionView
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 MyOClesson.com. All rights reserved.
//

#import "CustomReusableView.h"

@implementation CustomReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 10, 80, 30)];
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = CGRectMake(90, 14, 40, 20);
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

@end
