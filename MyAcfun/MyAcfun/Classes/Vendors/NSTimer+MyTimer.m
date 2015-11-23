//
//  NSTimer+MyTimer.m
//  豆瓣非可视化
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "NSTimer+MyTimer.h"

@implementation NSTimer (MyTimer)

// 开始
- (void)start{
    [self setFireDate:[NSDate date]];
}
// 暂停
- (void)pause{
    [self setFireDate:[NSDate distantFuture]];
}
// 结束
- (void)stop{
    [self invalidate];
}

@end
