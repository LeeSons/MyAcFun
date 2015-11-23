//
//  DataManager.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()

@property(nonatomic, strong)NSMutableDictionary *dataDict;

@end

@implementation DataManager
static DataManager *manager = nil;
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DataManager new];
    });
    return manager;
}

// 加载番剧
+ (void)loadDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page Sort:(NSInteger)sort Type:(NSInteger)type CallBack:(CBack)callBack{
    NSString *movieURL = [NSString stringWithFormat:@"%@%@%ld%@%@%ld%@%ld%@%ld",MOVIELIST_URL,MOVIE_PAGESIZE,pageSize,MOVIE_ISWEB,MOVIE_PAGENO,page,MOVIE_SORT,sort,MOVIE_TYPE,type];
    [LCPNetWorking getNetWorkingData:movieURL Method:@"get" Parameter:nil CallBack:^(id object, id error) {
        if (error != nil) {
            callBack(nil);
        }else{
            callBack(object);
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:movieURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        callBack(responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        callBack(nil);
//    }];
}
// 加载文章
+ (void)loadArticalDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack{
    NSString *articalURL = [NSString stringWithFormat:@"%@%@%ld%@%ld%@",ARTICEL_URL,ARTICEL_PAGESIZE,pageSize,ARTICEL_PAGENO,page,ARTICEL_OTHER];
    [LCPNetWorking getNetWorkingData:articalURL Method:@"get" Parameter:nil CallBack:^(id object, id error) {
        if (error != nil) {
            callBack(nil);
        }else{
            callBack(object);
        }
    }];
}
// 加载科技
+ (void)loadTECDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack{
    NSString *tecURL = [NSString stringWithFormat:@"%@%@%ld%@%ld%@",TEC_URL,TEC_PAGESIZE,pageSize,TEC_PAGENO,page,TEC_OTHER];
    [LCPNetWorking getNetWorkingData:tecURL Method:@"get" Parameter:nil CallBack:^(id object, id error) {
        if (error != nil) {
            callBack(nil);
        }else{
            callBack(object);
        }
    }];
}
// 加载音乐
+ (void)loadMusicDataWithPageSize:(NSInteger)pageSize Page:(NSInteger)page CallBack:(CBack)callBack{
    NSString *musicURL = [NSString stringWithFormat:@"%@%@%ld%@%ld%@",MUSIC_URL,MUSIC_PAGESIZE,pageSize,MUSIC_PAGENO,page,MUSIC_OTHER];
    [LCPNetWorking getNetWorkingData:musicURL Method:@"get" Parameter:nil CallBack:^(id object, id error) {
        if (error != nil) {
            callBack(nil);
        }else{
            callBack(object);
        }
    }];
}

#pragma mark -lazyLoad


@end
