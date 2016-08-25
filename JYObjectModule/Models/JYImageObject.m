//
//  JYImageObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYImageObject.h"

@implementation JYImageObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, url;
#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    NSMutableArray *indexed = [[super indexedProperties] mutableCopy];
    [indexed addObject:@"url"];
    return indexed;
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    NSMutableDictionary *defaults = [[super defaultPropertyValues] mutableCopy];
    return defaults;
}
+ (nullable NSString *)primaryKey
{
    return [super primaryKey];
}
+ (nullable NSArray *)ignoredProperties
{
    NSMutableArray *ignored = [[super ignoredProperties] mutableCopy];
    return ignored;
}
+ (NSArray *)requiredProperties
{
    NSMutableArray *required = [[super requiredProperties] mutableCopy];
    [required addObject:@"url"];
    return required;
}
@end