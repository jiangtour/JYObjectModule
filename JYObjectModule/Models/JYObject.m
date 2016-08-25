//
//  JYObject.m
//  AXHTTPClient
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "JYObject.h"

@implementation JYObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions;
#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return @[@"index", @"atUpdation", @"atCreation", @"descriptions"];
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    return @{@"index":@(-1)};
}
+ (nullable NSString *)primaryKey
{
    return @"objectId";
}
+ (nullable NSArray *)ignoredProperties
{
    return nil;
}
+ (NSArray *)requiredProperties
{
    return @[@"objectId"];
}
@end