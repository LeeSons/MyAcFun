//
//  Arcitle.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arcitle : NSObject
/*
 {
 "user": {
 "userId": 545398,
 "userImg": "http://cdn.aixifan.com/dotnet/20120923/style/image/avatar.jpg",
 "username": "微之若羽"
 },
 "tags": [],
 "title": "一段破感情，自己犯贱了，求朱军进来把我骂醒",
 "cover": "http://cdn.aixifan.com/dotnet/20120923/style/image/cover-night.png",
 "releaseDate": 1447805215000,
 "isRecommend": 0,
 "views": 896,
 "stows": 1,
 "comments": 39,
 "toplevel": 0,
 "contentId": 2333986,
 "channelId": 73,
 "isArticle": 1,
 "viewOnly": 0,
 "tudouDomain": 0,
 "description": "经常给别人解决感情问题，常常以知心大哥哥自称，没想到这次被雁子给啄了眼睛了，求朱军进来骂醒我"
 */
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
+ (instancetype)articleWithDictionary:(NSDictionary *)dictionary;

@end
