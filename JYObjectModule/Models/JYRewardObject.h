//
//  JYRewardObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/26.
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
/// Reward object protocol.
@protocol JYRewardObject <JYObject>
@required
/// @description Title of reward object.
@property(copy, nonatomic, nullable) NSString *title;
/// @description Detail of reward object.
@property(copy, nonatomic, nullable) NSString *detail;
/// @description Amount of reward object.
@property(assign, nonatomic) int64_t amount;
/// @description Type of reward object.
@property(assign, nonatomic) int64_t type;
/// @description Subtype of reward object.
@property(assign, nonatomic) int64_t subtype;
/// @description State of reward object.
@property(assign, nonatomic) int64_t state;
/// @description Substate of reward object.
@property(assign, nonatomic) int64_t substate;
@end
/// JYRewardObject.
@interface JYRewardObject : RLMObject <JYRewardObject>
@end