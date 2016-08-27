//
//  PostObject.m
//  AXHTTPClient
//
//  Created by devedbox on 16/8/27.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "PostObject.h"

@implementation PostObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, user, title, detail, content, images, readCount, commentCount, liked, likeCount, shareCount, comments;

+ (void)load {
    [super load];
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return @[@"index", @"atUpdation", @"atCreation", @"descriptions", @"title", @"detail", @"readCount", @"commentCount", @"liked", @"likeCount", @"shareCount"];
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    return @{@"index":@(-1), @"readCount":@(0), @"commentCount":@(0), @"liked":@(0), @"likeCount":@(0), @"shareCount":@(0)};
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