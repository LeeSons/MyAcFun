//
//  UIColor+RandomColor.m
//  HomeWork06
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 MyOClesson.com. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
}
@end
