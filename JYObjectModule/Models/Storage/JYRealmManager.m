//
//  JYRealmManager.m
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

#import "JYRealmManager.h"
#import "RLMRealmConfiguration+Client.h"

@interface JYRealmManager()
{
    dispatch_queue_t _queue;
    RLMRealm *_memoryRealm;
}
@property(strong, nonatomic) NSOperationQueue *operationQueue;
@property(strong, nonatomic) NSBlockOperation *operation;
@end

@implementation JYRealmManager
+ (instancetype)sharedManager {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        _operationQueue.name = @"com.realm.transaction.vivian";
        _queue = dispatch_queue_create("com.realm.transaction.vivian", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - Getters
- (RLMRealm *)currentRealm {
    NSError *error;
    RLMRealmConfiguration *config = [RLMRealmConfiguration currentConfiguration];
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:&error];
    return realm;
}

- (RLMRealm *)memoryRealm {
    if (_memoryRealm) return _memoryRealm;
    NSError *error;
    RLMRealmConfiguration *config = [[RLMRealmConfiguration defaultConfiguration] copy];
    config.inMemoryIdentifier = @"com.jiangyou.realm";
    _memoryRealm = [RLMRealm realmWithConfiguration:config error:&error];
    return _memoryRealm;
}

- (void)beginWriteTransaction:(JYRealmWriteTransactionBlock)transaction
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        RLMRealm *realm = self.currentRealm;
        if (transaction) {
            [realm beginWriteTransaction];
            transaction(realm);
            NSError *error;
            [realm commitWriteTransaction:&error];
        }
    }];
    [_operationQueue addOperation:operation];
}

- (void)beginTransaction:(JYRealmWriteTransactionBlock)transaction
{
    [self beginTransaction:transaction completion:nil];
}

- (void)beginTransaction:(JYRealmWriteTransactionBlock)transaction completion:(JYRealmWriteTransactionCompletionBlock)completion
{
    dispatch_async(_queue, ^{
        @autoreleasepool {
            RLMRealm *realm = self.currentRealm;
            @try {
                [realm beginWriteTransaction];
                if (transaction) {
                    transaction(realm);
                }
                NSError *error;
                [realm commitWriteTransaction:&error];
                if (completion) {
                    JYEXECUTE_ON_M_T(^(){
                        completion(error);
                    });
                }
            }
            @catch (NSException *exception) {
                NSLog(@"realm数据库写入失败，异常信息：%@", exception);
            }
            @finally {
                if (realm.inWriteTransaction) {
                    [realm commitWriteTransaction];
                }
                if (!realm.autorefresh) {
                    [realm refresh];
                }
            }
        }
    });
}
@end