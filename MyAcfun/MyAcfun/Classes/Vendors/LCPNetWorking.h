//
//  LCPNetWorking.h
//  网络请求类封装
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

typedef void (^CallBack)(id object,id error);
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LCPNetWorking : NSObject


// 获取网络图片接口
+(void)getNetImageData:(NSString *)url CallBack:(CallBack)callBack;

// 获取网络数据接口
+(void)getNetWorkingData:(NSString *)baseURL Method:(NSString *)method Parameter:(NSString *)par CallBack:(CallBack)callBack;

@end
