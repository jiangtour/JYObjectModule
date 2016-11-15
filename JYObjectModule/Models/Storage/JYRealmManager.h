//
//  JYRealmManager.h
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

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

#ifndef JY_RealmManager
#define JY_RealmManager ([JYRealmManager sharedManager])
#endif
#ifndef JY_Realm
#define JY_Realm (JY_RealmManager.currentRealm)
#endif
#ifndef JY_REALM_TRANSACTION_QUEUE
#define JY_REALM_TRANSACTION_QUEUE (JY_RealmManager.queue)
#endif
#ifndef JYEXECUTE_ON_M_T
#define JYEXECUTE_ON_M_T(block) \
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

NS_ASSUME_NONNULL_BEGIN
typedef void(^JYRealmWriteTransactionBlock)(RLMRealm *_Nonnull realm);
typedef void(^JYRealmWriteTransactionCompletionBlock)(NSError * _Nullable error);

@interface JYRealmManager : NSObject
/// Default realm
@property(readonly, nonatomic) RLMRealm *currentRealm;
/// Memory realm copy of default reamlm.
@property(readonly, nonatomic) RLMRealm *memoryRealm;
/// Last error
@property(readonly, nonatomic) NSError *error;
/// Transaction serial queue.
@property(readonly, nonatomic) dispatch_queue_t queue;

+ (instancetype)sharedManager;
/// Begin transaction using async method in user realm.
///
/// @param transaction writing transaction block.
- (void)beginTransaction:(nonnull JYRealmWriteTransactionBlock)transaction;
/// Begin transaction using async method with completion block in user realm.
///
/// @param transaction writing transaction block.
/// @param completion completion block.
- (void)beginTransaction:(nonnull JYRealmWriteTransactionBlock)transaction completion:(nullable JYRealmWriteTransactionCompletionBlock)completion;
/// Async transaction with completion in user realm.
///
/// @param transaction writing transaction block.
/// @param completion completion block.
- (void)asynsTransaction:(nonnull JYRealmWriteTransactionBlock)transaction completion:(nullable JYRealmWriteTransactionCompletionBlock)completion;
/// Async transaction with completion.
///
/// @param transaction writing transaction block.
/// @param realm realm to begin transactin.
/// @param completion completion block.
- (void)asynsTransaction:(nonnull JYRealmWriteTransactionBlock)transaction inRealm:(RLMRealm *_Nullable)realm completion:(nullable JYRealmWriteTransactionCompletionBlock)completion;
/// Sync transaction with completion in user realm.
///
/// @param transaction writing transaction block.
- (void)syncTransaction:(nonnull JYRealmWriteTransactionBlock)transaction;
/// Sync transaction with completion.
///
/// @param transaction writing transaction block.
/// @param realm realm to begin transactin.
- (void)syncTransaction:(nonnull JYRealmWriteTransactionBlock)transaction inRealm:(RLMRealm *_Nullable)realm;
@end
NS_ASSUME_NONNULL_END
