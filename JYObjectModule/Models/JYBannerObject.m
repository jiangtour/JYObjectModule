//
//  JYBannerObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYBannerObject.h"

@implementation JYBannerObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, imageURL, url, priority, type, subtype, referenceId;
#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    NSMutableArray *indexed = [[super indexedProperties] mutableCopy];
    [indexed addObjectsFromArray:@[@"url", @"priority"]];
    return indexed;
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    NSMutableDictionary *defaults = [[super defaultPropertyValues] mutableCopy];
    [defaults addEntriesFromDictionary:@{@"priority":@(-1), @"type":@(-1), @"subtype":@(-1)}];
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
    [required addObjectsFromArray:@[@"imageURL"]];
    return required;
}
@end