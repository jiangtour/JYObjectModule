//
//  JYIdentifierObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYIdentifierObject <JYObject>
@required
/// State of identifier verify.
///
@property(assign, nonatomic) int64_t state;
/// Substate of identifier verify.
///
@property(assign, nonatomic) int64_t substate;
/// Name of user.
///
@property(copy, nonatomic, nonnull) NSString *name;
/// Identifier number of user.
///
@property(copy, nonatomic, nonnull) NSString *identifier;
/// Phone number of user.
///
@property(copy, nonatomic, nullable) NSString *phone;
/// Statements of identifier state/substate.
///
@property(copy, nonatomic, nullable) NSString *statements;
@end

@interface JYIdentifierObject : RLMObject <JYIdentifierObject>
@end