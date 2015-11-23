//
//  Technology.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Technology : NSObject
@property(nonatomic, strong) NSDictionary * user;
@property(nonatomic, strong) NSArray * tags;
@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSString * cover;
@property(nonatomic, assign) NSInteger releaseDate;
@property(nonatomic, assign) BOOL isRecommend;
@property(nonatomic, assign) NSInteger views; // 阅读数
@property(nonatomic, assign) NSInteger stows;
@property(nonatomic, assign) NSInteger comments; // 评论数
@property(nonatomic, assign) BOOL toplevel;
@property(nonatomic, assign) NSInteger contentId;
@property(nonatomic, assign) NSInteger channelId;
@property(nonatomic, assign) BOOL isArticle;
@property(nonatomic, assign) BOOL viewOnly;
@property(nonatomic, assign) BOOL tudouDomain;
@property(nonatomic, strong) NSString * descriptions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)technologyWithDictionary:(NSDictionary *)dictionary;

@end
