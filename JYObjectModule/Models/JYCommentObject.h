//
//  JYCommentObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYUserObject.h"
#import "JYImageObject.h"

@protocol JYCommentObject <JYObject>
@required
/// Content of comment.
///
@property(copy, nonatomic, nonnull) NSString *content;
/// Commenting user of comment.
///
@property(strong, nonatomic, nonnull) id<JYUserObject> user;
/// Commented user of comment.
///
@property(strong, nonatomic, nullable) id<JYUserObject> atUser;
/// Images of comment.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYImageObject *><JYImageObject> *images;
@end

@interface JYCommentObject : RLMObject <JYCommentObject>
/// Commenting user of comment.
///
@property(strong, nonatomic, nonnull) __kindof JYUserObject *user;
/// Commented user of comment.
///
@property(strong, nonatomic, nullable) __kindof JYUserObject *atUser;
@end