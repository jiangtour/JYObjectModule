//
//  JYIntegerObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYIntegerObject.h"

@implementation JYIntegerObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, integer;
+ (NSArray *)indexedProperties
{
    NSMutableArray *indexed = [[super indexedProperties] mutableCopy];
    [indexed addObjectsFromArray:@[@"integer"]];
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
    return required;
}
@end