//
//  JYWalletObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYWalletObject <JYObject>
@required
/// Amount of wallet.
///
@property(assign, nonatomic) long amount;
/// Amount to withdrawal.
///
@property(assign, nonatomic) long withdrawal;
/// Blocked amount.
///
@property(assign, nonatomic) long blocked;
/// Income amount totally.
///
@property(assign, nonatomic) long income;
/// Outcome amount totally.
///
@property(assign, nonatomic) long outcome;
@end

@interface JYWalletObject : RLMObject <JYWalletObject>
@end