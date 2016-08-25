//
//  JYObject.h
//  AXHTTPClient
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@protocol JYObject <NSObject>
@required
/// Object id of instance from server.
///
@property(copy, nonatomic, nonnull) NSString *objectId;
/// User id of current logined user.
///
@property(copy, nonatomic, nullable) NSString *userId;
/// Index of object.
///
@property(assign, nonatomic) int64_t index;
/// Time stack of creation time of object.
///
@property(assign, nonatomic) int64_t atCreation;
/// Time stack of updation time of object.
///
@property(assign, nonatomic) int64_t atUpdation;
/// Descriptions of object.
///
@property(copy, nonatomic, nullable) NSString *descriptions;
@end

@interface JYObject : RLMObject <JYObject>
@end