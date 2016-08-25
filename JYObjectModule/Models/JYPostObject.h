//
//  JYPostObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYUserObject.h"
#import "JYImageObject.h"
#import "JYCommentObject.h"

@protocol JYPostObject <JYObject>
@required
/// User who post the content.
///
@property(strong, nonatomic, nonnull) id<JYUserObject> user;
/// Title of post.
///
@property(copy, nonatomic, nonnull) NSString  *title;
/// Detail of post.
///
@property(copy, nonatomic, nullable) NSString *detail;
/// Content of post.
///
@property(copy, nonatomic, nullable) NSString *content;
/// Count of read times.
///
@property(assign, nonatomic) int64_t readCount;
/// Count of commented times.
///
@property(assign, nonatomic) int64_t commentCount;
/// Is current user liked the post.
///
@property(assign, nonatomic) BOOL    liked;
/// Count of liked times.
///
@property(assign, nonatomic) int64_t likeCount;
/// Count of shared times.
///
@property(assign, nonatomic) int64_t shareCount;
/// Images of post.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYImageObject *><JYImageObject> *images;
/// Comments of post.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYCommentObject *><JYCommentObject> *comments;
@end

@interface JYPostObject : RLMObject <JYPostObject>
/// User who post the content.
///
@property(strong, nonatomic, nonnull) __kindof JYUserObject *user;
@end