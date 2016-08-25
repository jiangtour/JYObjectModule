//
//  JYWithdrawalObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYWithdrawalObject <JYObject>
@required
/// Amount of withdrawal.
///
@property(assign, nonatomic) int64_t amount;
/// State of withdrawal object.
///
@property(assign, nonatomic) int64_t state;
/// Substate of withdrawal object.
///
@property(assign, nonatomic) int64_t substate;
/// Statements of withdrawal.
///
@property(copy, nonatomic, nullable) NSString *statements;
/// Account of withdrawal.
///
@property(copy, nonatomic, nullable) NSString *account;
@end

@interface JYWithdrawalObject : RLMObject <JYWithdrawalObject>
@end