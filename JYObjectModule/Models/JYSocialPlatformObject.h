//
//  JYSocialPlatformObject.h
//  JYObjectModule
//
//  Created by devedbox on 2016/11/29.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYUserObject.h"

@protocol JYSocialPlatformObject <JYUserObject>
/**
 uid.
 */
@property(copy, nonatomic, nonnull) NSString *uId;
/**
 Open id.
 */
@property(copy, nonatomic, nullable) NSString *openId;
/**
 Access token.
 */
@property(copy, nonatomic, nullable) NSString *accessToken;
/**
 Expire date.
 */
@property(assign, nonatomic) double expireDate;
/**
 Refresh token.
 */
@property(copy, nonatomic, nullable) NSString *refreshToken;
/**
 Platform type.
 */
@property(assign, nonatomic) int64_t platform;
@end

@interface JYSocialPlatformObject : JYRLMObject <JYSocialPlatformObject>
@end
