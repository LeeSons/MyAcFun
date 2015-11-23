//
//  MyNavigationBar.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                [view removeFromSuperview];
            }
        }
    }
    return self;
}

@end
