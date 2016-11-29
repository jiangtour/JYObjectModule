//
//  JYSocialPlatformObject.m
//  JYObjectModule
//
//  Created by devedbox on 2016/11/29.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYSocialPlatformObject.h"

@implementation JYSocialPlatformObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, avatar, nickname, phone, gender, birthday, uId, openId, accessToken, expireDate, refreshToken, platform;

+ (void)load {
    [super load];
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return [[super indexedProperties] addObjectsFromArray:@[@"phone", @"birthday", @"uId", @"openId", @"accessToken", @"refreshToken", @"platform"]];
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    return [super defaultPropertyValues];
}
+ (nullable NSString *)primaryKey
{
    return [super primaryKey];
}
+ (nullable NSArray *)ignoredProperties
{
    return [super ignoredProperties];
}
+ (NSArray *)requiredProperties
{
    return [super requiredProperties];
}
@end
