//
//  LCPNetWorking.m
//  网络请求类封装
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "LCPNetWorking.h"
@implementation LCPNetWorking


// 加载网络图片接口
+(void)getNetImageData:(NSString *)url CallBack:(CallBack)callBack{
    LCPNetWorking *net = [LCPNetWorking new];
    [net getNetData:url Parameter:nil Method:@"get" CallBack:^(id object, id error) {
        NSData *data = (NSData *)object;
        if (data == nil) {
            callBack(nil,error);
        }else{
             dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *img = [UIImage imageWithData:data];
                callBack(img,nil);
            });
        }
    }];
}

// 获取网络数据接口
+(void)getNetWorkingData:(NSString *)baseURL Method:(NSString *)method Parameter:(NSString *)par CallBack:(CallBack)callBack{
    LCPNetWorking *net = [LCPNetWorking new];
    [net getNetData:baseURL Parameter:par Method:method CallBack:^(id object,id error) {
        NSData *data = (NSData *)object;
        if (data == nil) {
            callBack(nil,error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                id parseData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                callBack(parseData,nil);
            });
        }
    }];
}

// 获取网络数据私有方法
- (void)getNetData:(NSString *)baseURL Parameter:(NSString *)par Method:(NSString *)method CallBack:(CallBack)callBack{
    // 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseURL]];
    if ([method isEqualToString:@"post"]) {
        // 设置请求方式
        [request setHTTPMethod:method];
        // 设置请求参数
        NSData *tempData = [par dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:tempData];
    }
    // 创建session会话
    NSURLSession *session = [NSURLSession sharedSession];
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data == nil) {
            callBack(nil,error);
        }else{
            callBack(data,nil);
        }
    }];
    [task resume];
}

@end
