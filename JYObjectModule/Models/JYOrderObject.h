//
//  JYOrderObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYProductObject.h"

@protocol JYOrderObject <JYObject>
@required
/// State of order.
///
@property(assign, nonatomic) int64_t state;
/// Substate of order.
///
@property(assign, nonatomic) int64_t substate;
/// Product object.
///
@property(strong, nonatomic, nonnull) id<JYProductObject> product;
@end

@interface JYOrderObject : RLMObject <JYOrderObject>
@end