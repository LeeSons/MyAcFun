//
//  Movie.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(nonatomic, assign) NSInteger Id;
@property(nonatomic, assign) NSInteger views;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, assign) NSInteger lastUpdateTime;
@property(nonatomic, assign) NSInteger stows;
@property(nonatomic, assign) CGFloat heat;
@property(nonatomic, assign) NSInteger week;
@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign) NSInteger tudouomain;
@property(nonatomic, strong) NSString * coverHorizontal;
@property(nonatomic, strong) NSString * coverVertical;
@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSString * lastVideoName;
@property(nonatomic, strong) NSString * cover;
@property(nonatomic, strong) NSString * intro;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)movieWithDictionary:(NSDictionary *)dictionary;

@end
