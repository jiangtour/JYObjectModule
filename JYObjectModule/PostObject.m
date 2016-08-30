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
    return [[super indexedProperties] addObjectsFromArray:@[@"title", @"detail", @"readCount", @"commentCount", @"liked", @"likeCount", @"shareCount"]];
}
@end