//
//  Technology.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "Technology.h"

@implementation Technology
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (instancetype)technologyWithDictionary:(NSDictionary *)dictionary{
    Technology *technology = [[Technology alloc] initWithDictionary:dictionary];
    return technology;
}
@end
