//
//  JYChainObject.h
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
/*!
 *  JYChainObject protocol.
 */
@protocol JYChainObject;
/*!
 *  JYChainObject.
 */
@interface JYChainObject : JYRLMObject
@end
/*!
 *  Chain object protocol.
 */
@protocol  JYChainObject  <JYObject>
@required
/*!
 *  Father object id of chain.
 */
@property(copy, nonatomic, nullable) NSString *superId;
/*!
 *  Title of chain object.
 */
@property(copy, nonatomic, nullable) NSString *title;
/*!
 *  Detail of chain object.
 */
@property(copy, nonatomic, nullable) NSString *detail;
/*!
 *  Children of chain object.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYChainObject *><JYChainObject> *children;
@end
/*!
 *  JYChainObject<JYChainObject>
 */
@interface JYChainObject () <JYChainObject>
@end