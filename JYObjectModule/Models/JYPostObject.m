//
//  JYPostObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JYPostObject.h"

@implementation JYPostObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, user, title, detail, content, images, readCount, commentCount, liked, likeCount, shareCount, comments;

+ (void)load {
    [super load];
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return [[super indexedProperties] addObjectsFromArray:@[@"title", @"detail", @"readCount", @"commentCount", @"liked", @"likeCount", @"shareCount"]];
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    return [[super defaultPropertyValues] addEntriesFromDictionary:@{@"readCount":@(0), @"commentCount":@(0), @"liked":@(0), @"likeCount":@(0), @"shareCount":@(0)}];
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