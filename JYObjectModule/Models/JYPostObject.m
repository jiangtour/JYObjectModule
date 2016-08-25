//
//  JYPostObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYPostObject.h"

@implementation JYPostObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, user, title, detail, content, images, readCount, commentCount, liked, likeCount, shareCount, comments;
#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    NSMutableArray *indexed = [[super indexedProperties] mutableCopy];
    [indexed addObjectsFromArray:@[@"title", @"detail", @"readCount", @"commentCount", @"liked", @"likeCount", @"shareCount"]];
    return indexed;
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    NSMutableDictionary *defaults = [[super defaultPropertyValues] mutableCopy];
    [defaults addEntriesFromDictionary:@{@"readCount":@(0), @"commentCount":@(0), @"liked":@(0), @"likeCount":@(0), @"shareCount":@(0)}];
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
    return required;
}
@end
