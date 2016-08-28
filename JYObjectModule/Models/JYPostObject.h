//
//  JYPostObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JYObject.h"
#import "JYUserObject.h"
#import "JYImageObject.h"
#import "JYCommentObject.h"
/*!
 *  Post object protocol.
 */
@protocol JYPostObject <JYObject>
@required
/*!
 *  User who post the content.
 */
@property(strong, nonatomic, nonnull) id<JYUserObject> user;
/*!
 *  Title of post.
 */
@property(copy, nonatomic, nonnull) NSString  *title;
/*!
 *  Detail of post.
 */
@property(copy, nonatomic, nullable) NSString *detail;
/*!
 *  Content of post.
 */
@property(copy, nonatomic, nullable) NSString *content;
/*!
 *  Count of read times.
 */
@property(assign, nonatomic) int64_t readCount;
/*!
 *  Count of commented times.
 */
@property(assign, nonatomic) int64_t commentCount;
/*!
 *  Is current user liked the post.
 */
@property(assign, nonatomic) BOOL    liked;
/*!
 *  Count of liked times.
 */
@property(assign, nonatomic) int64_t likeCount;
/*!
 *  Count of shared times.
 */
@property(assign, nonatomic) int64_t shareCount;
/*!
 *  Images of post.
 */
@property(strong, nonatomic, nullable) RLMArray<JYImageObject> *images;
/*!
 *  Comments of post.
 */
@property(strong, nonatomic, nullable) RLMArray<JYCommentObject> *comments;
@end
/*!
 *  JYPostObject.
 */
@interface JYPostObject : JYRLMObject <JYPostObject>
/*!
 *  User who post the content.
 */
@property(strong, nonatomic, nonnull) __kindof JYUserObject *user;
/*!
 *  Images of post.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYImageObject *><JYImageObject> *images;
/*!
 *  Comments of post.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYCommentObject *><JYCommentObject> *comments;
@end