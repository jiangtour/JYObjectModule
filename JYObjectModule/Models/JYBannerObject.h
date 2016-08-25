//
//  JYBannerObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYBannerObject <JYObject>
@required
/// Post image url of banner object.
///
@property(copy, nonatomic, nonnull) NSString *imageURL;
/// Url address of banner object.
///
@property(copy, nonatomic, nullable) NSString *url;
/// Priority of banner object shows at client.
///
@property(assign, nonatomic) int64_t priority;
/// Type of banner object.
///
@property(assign, nonatomic) int64_t type;
/// Subtype of banner object.
///
@property(assign, nonatomic) int64_t subtype;
/// Refrenced object id of banner object.
///
@property(copy, nonatomic, nullable) NSString *referenceId;
@end

@interface JYBannerObject : RLMObject <JYBannerObject>
@end