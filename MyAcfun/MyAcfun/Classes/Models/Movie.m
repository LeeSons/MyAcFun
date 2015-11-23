//
//  Movie.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.Id = [value integerValue];
    }
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (instancetype)movieWithDictionary:(NSDictionary *)dictionary{
    Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
    return movie;
}

@end
