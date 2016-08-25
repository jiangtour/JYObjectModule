//
//  JYCashbackObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYUserObject.h"

@protocol JYCashbackObject <JYObject>
@required
/// User where the cash back from.
///
@property(strong, nonatomic, nonnull) id<JYUserObject> user;
/// Type of cashback object.
///
@property(assign, nonatomic) int64_t type;
/// Subtype of cashback object.
///
@property(assign, nonatomic) int64_t subtype;
/// Amount of cashback object.
///
@property(assign, nonatomic) int64_t amount;
/// Statements of cash back.
///
@property(copy, nonatomic, nullable) NSString *statements;
@end

@interface JYCashbackObject : RLMObject <JYCashbackObject>
@end