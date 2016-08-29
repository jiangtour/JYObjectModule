//
//  JYResponseObject.h
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

#import "JYPageObject.h"

/*!
 Object types for response object.
 */
//
/*!
 *  Object type identifier.
 */
static NSString *const _Nonnull JYResponseTypeObject = @"object";
/*!
 *  List type identifier.
 */
static NSString *const _Nonnull JYResponseTypeList   = @"list";
/*!
 *  Null type identifier.
 */
static NSString *const _Nonnull JYResponseTypeNull   = @"null";
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
/*!
 *  Get the class name of object type string.
 *
 *  @param object object type string.
 *
 *  @return Object type class.
 */
static Class _Nullable JYResponseClassWithObjectTypeString(NSString * _Nonnull object) {
    // Get the components of object type string.
    NSArray *components = [object componentsSeparatedByString:@"/"];
    // If count of components is not 3, then quit with nil.
    if (components.count != 3) {
        return nil;
    }
    // Get the class info of object type string.
    NSString *classInfo = components[1];
    // Get the class components of class info.
    NSArray *classComponents = [classInfo componentsSeparatedByString:@"."];
    
    return NSClassFromString([classComponents lastObject]);
}
/*!
 *  Get the web module of response.
 *
 *  @param object object object type string.
 *
 *  @return Object web module.
 */
static NSString * _Nonnull JYResponseWebModuleWithObjectTypeString(NSString *_Nonnull object) {
    // Get the components of object type string.
    NSArray *components = [object componentsSeparatedByString:@"/"];
    // If count of components is not 3, then quit with nil.
    if (components.count != 3) {
        return nil;
    }
    
    return [components firstObject];
}
/*!
 *  Get the web module of response.
 *
 *  @param object object object object type string.
 *
 *  @return Object type.
 */
static NSString * _Nonnull JYResponseTypesWithObjectTypeString(NSString *_Nonnull object) {
    // Get the components of object type string.
    NSArray *components = [object componentsSeparatedByString:@"/"];
    // If count of components is not 3, then quit with nil.
    if (components.count != 3) {
        return nil;
    }
    
    return [components lastObject];
}
#pragma clang diagnostic pop
@protocol JYResponseObject <NSObject>
@required
/*!
 *  Status code.
 */
@property(assign, nonatomic) int64_t code;
/*!
 *  Status info message.
 */
@property(copy, nonatomic, nullable) NSString *message;
/*!
 *  Data object type string of response object.
 */
@property(copy, nonatomic, nonnull) NSString  *object;
/*!
 *  Page info for list objects.
 */
@property(strong, nonatomic, nullable) id<JYPageObject> page;
/*!
 *  Data for response.
 */
@property(strong, nonatomic, nullable) id/*data:{string/dictionary}*/data;
@end
/*!
 *  JYResponseObject.
 */
@interface JYResponseObject : NSObject <JYResponseObject>
/*!
 *  Page info.
 */
@property(strong, nonatomic, nullable) __kindof JYPageObject *page;
@end