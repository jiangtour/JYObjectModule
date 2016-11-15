//
//  RLMRealm+CSV.m
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

#import <SDWebImage/SDWebImageManager.h>
#import "RLMRealmConfiguration+Client.h"
#import "RLMRealm+DataHandler.h"
#import "JYRealmManager.h"

@implementation RLMRealm (DataHandler)
+ (void)clearCache:(JYShouldClearCacheCall)shouldClear completion:(JYClearCacheCompletionCall)completion {
    NSFileManager* manager = [NSFileManager defaultManager];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *url = [NSURL fileURLWithPath:[RLMRealmConfiguration realmDir] isDirectory:YES];
        NSUInteger totalSize = 0;
        
        NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtURL:url
                                              includingPropertiesForKeys:@[NSFileSize]
                                                                 options:NSDirectoryEnumerationSkipsHiddenFiles
                                                            errorHandler:NULL];
        
        for (NSURL *fileURL in fileEnumerator) {
            NSNumber *fileSize;
            [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
            totalSize += [fileSize unsignedIntegerValue];
        }
        NSDirectoryEnumerator *fileEnumeratorTmp = [manager enumeratorAtURL:[NSURL URLWithString:NSTemporaryDirectory()]
                                                 includingPropertiesForKeys:@[NSFileSize]
                                                                    options:NSDirectoryEnumerationSkipsHiddenFiles
                                                               errorHandler:NULL];
        for (NSURL *fileURL in fileEnumeratorTmp) {
            NSNumber *fileSize;
            [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
            totalSize += [fileSize unsignedIntegerValue];
        }
        [[SDWebImageManager sharedManager].imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger size) {
            if (shouldClear(totalSize+size)) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
                        NSArray *tmpPaths = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
                        for (NSString *path in tmpPaths) {
                            NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:path];
                            NSError *error;
                            if (![manager removeItemAtPath:filePath error:&error]) {
                                NSLog(@"remove file failed:%@", error);
                            }
                        }
                        [JY_RealmManager beginTransaction:^(RLMRealm * _Nonnull realm) {
                            [realm deleteAllObjects];
                        } completion:^(NSError * _Nullable error) {
                            [JY_Realm refresh];
                            [JY_Realm invalidate];
                            if (completion) {
                                [[SDWebImageManager sharedManager].imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger size) {
                                    NSUInteger _size = 0;
                                    for (NSURL *fileURL in fileEnumerator) {
                                        NSNumber *fileSize;
                                        [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
                                        _size += [fileSize unsignedIntegerValue];
                                    }
                                    completion(_size+size);
                                }];
                            }
                        }];
                    }];
                });
            }
        }];
    });
}

+ (void)calculateCacheSizeIgnoreDefaultRealm:(BOOL)ignore completion:(void (^)(NSInteger, NSError *))completion {
    // Calculate the size of realm file system.
    // Calculate in background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Get realm file url.
        NSURL *url = [NSURL fileURLWithPath:[RLMRealmConfiguration realmDir] isDirectory:YES];
        NSUInteger totalSize = 0;
        
        NSError *error;
        
        totalSize += [self sizeForFilesInFileURL:url error:&error];
        
        if (!ignore) {
            NSNumber *fileSize;
            [[RLMRealmConfiguration defaultConfiguration].fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:&error];
            totalSize += [fileSize unsignedIntegerValue];
        }
        
        totalSize += [self sizeForFilesInFileURL:[NSURL URLWithString:NSTemporaryDirectory()] error:&error];
        
        totalSize += [SDWebImageManager.sharedManager.imageCache getSize];
        
        if (completion) {dispatch_async(dispatch_get_main_queue(), ^{completion(totalSize, error);});}
    });
}

+ (void)clearUserCacheCompletion:(void (^)(NSError *))completion {
    [SDWebImageManager.sharedManager.imageCache clearDisk];
    NSError *error;
    for (NSString *path in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL] copy]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:path] error:&error];
    }
    [self makeCopyVersionsOfRealm:JY_Realm];
    [self makeCopyVersionsOfRealm:[RLMRealm defaultRealm]];
    dispatch_sync(JY_REALM_TRANSACTION_QUEUE, ^{
        RLMRealm *realm = JY_Realm;
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
        [realm refresh];
    });
    if (completion) completion(error);
}

+ (NSInteger)sizeForFilesInFileURL:(NSURL *)fileURL error:(NSError **)error {
    NSUInteger totalSize = 0;
    
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtURL:fileURL includingPropertiesForKeys:@[NSFileSize] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:^BOOL(NSURL * _Nonnull url, NSError * _Nonnull error) {
        return YES;
    }];
    
    for (NSURL *fileURL in fileEnumerator) {
        NSNumber *fileSize;
        [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:error];
        totalSize += [fileSize unsignedIntegerValue];
    }
    
    return totalSize;
}

+ (void)makeCopyVersionsOfRealm:(RLMRealm *)realm {
    NSURL *realmFileURL = realm.configuration.fileURL;
    NSString *tmpRealmPath = [realm.configuration.fileURL.relativePath stringByDeletingLastPathComponent];
    
    [realm writeCopyToURL:[NSURL fileURLWithPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm"]] encryptionKey:nil error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[realmFileURL relativePath] error:nil];
    
    RLMRealm *copy = [RLMRealm realmWithURL:[NSURL fileURLWithPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm"]]];
    [copy writeCopyToURL:realmFileURL encryptionKey:nil error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm"] error:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm.lock"]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm.lock"] error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm.management/"]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[tmpRealmPath stringByAppendingPathComponent:@"_copy.realm.management/"] error:nil];
    }
}
@end
