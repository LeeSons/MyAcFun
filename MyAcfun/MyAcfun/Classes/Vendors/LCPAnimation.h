//
//  LCPAnimation.h
//  LCPAnimation
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum :NSUInteger{
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Open,                       //掀开
    Cover,                      //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吸走
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //打开镜头快门
    CameraIrisHollowClose,      //关闭镜头快门
    CurlDown,                   //向下翻页
    CurlUp,                     //向上翻页
    FlipFromLeft,               //向左翻转
    FlipFromRight,              //向右翻转
} AnimationType;

@interface LCPAnimation : NSObject

// 设置动画接口
// 参数说明：1：枚举类型的动画类型，2：持续时间 3：操作的视图
- (void) setViewAnimationWithAnimationType:(const AnimationType)animationType Duration:(CGFloat)duration View:(UIView *)view;




@end
