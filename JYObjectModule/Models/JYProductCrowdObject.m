//
//  JYProductCrowdObject.m
//  JYObjectModule
//
//  Created by devedbox on 2016/10/13.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYProductCrowdObject.h"

@implementation JYProductCrowdObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, gender, young, old, statements;
+ (void)load {
    [super load];
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return [[super indexedProperties] addObjectsFromArray:@[@"gender", @"old", @"young", @"statements"]];
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
