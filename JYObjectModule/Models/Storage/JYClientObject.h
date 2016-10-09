//
//  JYClientUserObject.h
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
/*!
 *  Client object protocol.
 */
@protocol JYClientObject <JYObject>
@required
/*!
 *  Is user signed in.
 */
@property(assign, nonatomic) BOOL actived;
/**
 Get the class of user object to fetch objects from realm.
 
 @return a Class for user objects.
 */
+ (Class _Nonnull)classForUserObjects;
@end
/*!
 *  JYClientObject
 */
@interface JYClientObject : JYRLMObject <JYClientObject>

+ (instancetype _Nullable)activedClient;

+ (id<JYUserObject> _Nullable)activedUser;

+ (void)activeClientWithUserId:(NSString * _Nonnull)userId;

+ (BOOL)unactiveClientWithUserId:(NSString * _Nonnull)userId;


/// Store the token in the realm with.
///
/// @param token token.
+ (void)storeClientTokenWithToken:(NSString *_Nonnull)token;

+ (void)storeEtag:(NSString *_Nonnull)etag forEtagFlag:(NSString *_Nonnull)etagFlag;
+ (NSString *_Nonnull)etagForEtagFlag:(NSString *_Nonnull)etagFlag;
@end
