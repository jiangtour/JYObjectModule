//
//  RLMRealmConfiguration+Client.m
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

#import "RLMRealmConfiguration+Client.h"
#import "RLMRealm+Migration.h"
#import "JYClientObject.h"

@implementation RLMRealmConfiguration (Client)
+ (instancetype)currentConfiguration
{
    RLMRealmConfiguration *config = [[RLMRealmConfiguration alloc] init];
    config.schemaVersion = [RLMRealm schemaVersion];
    [self realmDir];
    NSString *path = [self realmPath];
    if (!path) return [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL fileURLWithPath:path];
    return config;
}

+ (NSString *)realmPath
{
    // Get the actived user object.
    id<JYUserObject> user = JYClientObject.activedUser;
    if (!user) {
        return nil;
    }
    NSString *userId = user.userId;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // Get realm path with user id.
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"realm/%@/storage.realm", userId]];
    return path;
}

+ (NSString *)realmDir {
    // Get the actived user object.
    id<JYUserObject> user = JYClientObject.activedUser;
    if (!user) {
        return nil;
    }
    NSString *userId = user.userId;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dir = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"realm/%@/", userId]];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:dir
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error != nil) {
            return nil;
        }
    }
    return dir;
}
@end