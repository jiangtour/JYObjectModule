//
//  JYChainObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYChainObject;

@interface JYChainObject : RLMObject
@end

@protocol  JYChainObject  <JYObject>
@required
/// Father object id of chain.
///
@property(copy, nonatomic, nullable) NSString *superId;
/// Title of chain object.
///
@property(copy, nonatomic, nullable) NSString *title;
/// Detail of chain object.
///
@property(copy, nonatomic, nullable) NSString *detail;
/// Children of chain object.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYChainObject *><JYChainObject> *children;
@end

@interface JYChainObject () <JYChainObject>
@end