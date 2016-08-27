//
//  PostObject.h
//  AXHTTPClient
//
//  Created by devedbox on 16/8/27.
//  Copyright © 2016年 devedbox. All rights reserved.
//
#import "JYPostObject.h"
#import "UserObject.h"

@interface PostObject : JYRLMObject <JYPostObject>
/// User who post the content.
@property(strong, nonatomic, nonnull) UserObject *user;
@end
