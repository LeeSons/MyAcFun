//
//  NetStataHelper.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "NetStataHelper.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface NetStataHelper ()

@end

@implementation NetStataHelper
static NetStataHelper *helper = nil;
+(NetStataHelper *)defultNetStata{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NetStataHelper alloc] init];
    });
    return helper;
}


@end
