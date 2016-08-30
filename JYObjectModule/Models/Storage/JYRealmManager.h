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
/// Transaction queue
@property(readonly, nonatomic) dispatch_queue_t queue;

+ (instancetype)sharedManager;

- (void)beginWriteTransaction:(nonnull JYRealmWriteTransactionBlock)transaction __deprecated_msg("using 'beginTransaction:' method instead.");
- (void)beginTransaction:(nonnull JYRealmWriteTransactionBlock)transaction;
- (void)beginTransaction:(nonnull JYRealmWriteTransactionBlock)transaction completion:(nullable JYRealmWriteTransactionCompletionBlock)completion;
@end
NS_ASSUME_NONNULL_END