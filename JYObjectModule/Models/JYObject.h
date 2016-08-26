//
//  JYObject.h
//  AXHTTPClient
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 devedbox. All rights reserved.
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

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
/*!
 *  Basic object protocol of JYObjectModule.
 */
@protocol JYObject <NSObject>
@required
/*!
 *  Object id of instance from server.
 */
@property(copy, nonatomic, nonnull) NSString *objectId;
/*!
 *  User id of current logined user.
 */
@property(copy, nonatomic, nullable) NSString *userId;
/*!
 *  Index of object.
 */
@property(assign, nonatomic) int64_t index;
/*!
 *  Time stack of creation time of object.
 */
@property(assign, nonatomic) int64_t atCreation;
/*!
 *  Time stack of updation time of object.
 */
@property(assign, nonatomic) int64_t atUpdation;
/*!
 *  Descriptions of object.
 */
@property(copy, nonatomic, nullable) NSString *descriptions;
@end
/*!
 *  JYObject.
 */
@interface JYObject : RLMObject <JYObject>
@end