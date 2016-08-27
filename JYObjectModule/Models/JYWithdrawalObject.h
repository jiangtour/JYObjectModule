//
//  JYWithdrawalObject.h
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
 *  Withdrawal object protocol.
 *
 *  @discusstion The object is defined inherited the RLMObject. If you would like to override the properties, redefined a class and confirm to protocols and redeclare the custom proprties.
 If you would like to add new properties. Subclass a new class inherited from the JYClass and add your new properties.
 *
 *  \@interface OverridePostObject: JYRLMObject <JYPostObject>
 
 // new user object.
 
 \@property() CustomUserObject *user;
 
 \@end
 *
 *  \@interface AddPostObject: JYPostObject
 
 // new user object.
 
 \@property() CustomProperty *newProperty;
 
 \@end
 */
@protocol JYWithdrawalObject <JYObject>
@required
/*!
 *  Amount of withdrawal.
 */
@property(assign, nonatomic) int64_t amount;
/*!
 *  State of withdrawal object.
 */
@property(assign, nonatomic) int64_t state;
/*!
 *  Substate of withdrawal object.
 */
@property(assign, nonatomic) int64_t substate;
/*!
 *  Statements of withdrawal.
 */
@property(copy, nonatomic, nullable) NSString *statements;
/*!
 *  Account of withdrawal.
 */
@property(copy, nonatomic, nullable) NSString *account;
@end
/*!
 *  Account of withdrawal.
 */
@interface JYWithdrawalObject : JYRLMObject <JYWithdrawalObject>
@end