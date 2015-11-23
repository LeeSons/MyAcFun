//
//  DataManager.h
//  MyAcfun
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CBack)(id jsonObject);
@interface DataManager : NSObject
+ (instancetype)sharedManager;

// 加载番剧
+ (void)loadDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page Sort:(NSInteger)sort Type:(NSInteger)type CallBack:(CBack)callBack;
// 加载文章
+ (void)loadArticalDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack;
// 加载科技
+ (void)loadTECDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack;
// 加载音乐
+ (void)loadMusicDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack;
@end
