//
//  JYCashbackObject.h
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
/// Cashback object protocol.
@protocol JYCashbackObject <JYObject>
@required
/// User where the cash back from.
@property(strong, nonatomic, nonnull) id<JYUserObject> user;
/// Type of cashback object.
@property(assign, nonatomic) int64_t type;
/// Subtype of cashback object.
@property(assign, nonatomic) int64_t subtype;
/// Amount of cashback object.
@property(assign, nonatomic) int64_t amount;
/// Statements of cash back.
@property(copy, nonatomic, nullable) NSString *statements;
@end
/// JYCashbackObject.
@interface JYCashbackObject : RLMObject <JYCashbackObject>
@end