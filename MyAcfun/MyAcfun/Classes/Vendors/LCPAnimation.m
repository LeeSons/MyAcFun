//
//  LCPAnimation.m
//  LCPAnimation
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#define FromLeft      kCATransitionFromLeft
#define FromBottom    kCATransitionFromTop
#define FromRight     kCATransitionFromRight
#define FromTop       kCATransitionFromBottom

#import "LCPAnimation.h"

@implementation LCPAnimation

- (void) setViewAnimationWithAnimationType:(const AnimationType)animationType Duration:(CGFloat)duration View:(UIView *)view{
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case Push:
            [self transitionWithType:kCATransitionPush SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case Open:
            [self transitionWithType:kCATransitionReveal SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case Cover:
            [self transitionWithType:kCATransitionMoveIn SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case Cube:
            [self transitionWithType:@"cube" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case SuckEffect:
            [self transitionWithType:@"suckEffect" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case OglFlip:
            [self transitionWithType:@"oglFlip" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case PageCurl:
            [self transitionWithType:@"pageCurl" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" SubType:[self getSubType] Duration:duration UIView:view];
            break;
        case CurlDown:
            [self animationWithView:view duration:duration Transition:UIViewAnimationTransitionCurlDown];
            break;
        case CurlUp:
            [self animationWithView:view duration:duration Transition:UIViewAnimationTransitionCurlUp];
            break;
        case FlipFromLeft:
            [self animationWithView:view duration:duration Transition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:view duration:duration Transition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
}

// layer过渡动画封装，支持动画效果:
/* Fade = 1,                 //淡入淡出
 Push,                       //推挤
 Oper,                       //掀开
 Cover,                      //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 */
- (void)transitionWithType:(NSString *)animationType SubType:(NSString *)subType Duration:(CGFloat)duration UIView:(nonnull UIView *)view{
    CATransition *animation = [CATransition animation];
    // 设置运动时间
    animation.duration = duration;
    // 设置运动类型
    animation.type = animationType;
    // 设置运动方向
    if (subType != nil) {
        animation.subtype = subType;
    }
    // 向视图添加动画
    [view.layer addAnimation:animation forKey:@"animation"];
}


// UIView Block动画封装，支持动画：
/*
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转
 */
- (void)animationWithView:(nonnull UIView *)view duration:(NSTimeInterval)duration Transition:(UIViewAnimationTransition)transition{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}


// 随机获取方向
- (NSString *)getSubType{
    NSString *subType = nil;
    int from = arc4random() % 4;
    switch (from) {
        case 0:
            subType = FromTop;
            break;
        case 1:
            subType = FromLeft;
            break;
        case 2:
            subType = FromBottom;
            break;
        case 3:
            subType = FromRight;
            break;
    }
    return subType;
}

@end
