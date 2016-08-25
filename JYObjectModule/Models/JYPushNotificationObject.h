//
//  JYPushNotificationObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYImageObject.h"

@protocol JYPushNotificationObject <JYObject>
@required
/// Type of notification object.
///
@property(assign, nonatomic) int64_t type;
/// Subtype of notification object.
///
@property(assign, nonatomic) int64_t subtype;
/// Content of push notification object.
///
@property(copy, nonatomic, nullable) NSString *content;
/// Image url of push notification object.
///
@property(copy, nonatomic, nullable) NSString *image;
@end

@interface JYPushNotificationObject : RLMObject <JYPushNotificationObject>
@end