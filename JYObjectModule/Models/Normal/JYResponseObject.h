//
//  JYResponseObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYPageObject.h"

/*!
 Object types for response object.
 */
//
/// Object type identifier.
///
static NSString *const _Nonnull JYResponseTypeObject = @"object";
/// List type identifier.
///
static NSString *const _Nonnull JYResponseTypeList   = @"list";
/// Null type identifier.
///
static NSString *const _Nonnull JYResponseTypeNull   = @"null";
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
/// Get the class name of object type string.
///
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
    
    return [classComponents lastObject];
}
/// Get the web module of response.
///
static NSString * _Nonnull JYResponseWebModuleWithObjectTypeString(NSString *_Nonnull object) {
    // Get the components of object type string.
    NSArray *components = [object componentsSeparatedByString:@"/"];
    // If count of components is not 3, then quit with nil.
    if (components.count != 3) {
        return nil;
    }
    
    return [components firstObject];
}
/// Get the web module of response.
///
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
/// Status code.
///
@property(assign, nonatomic) int64_t code;
/// Status info message.
///
@property(copy, nonatomic, nullable) NSString *message;
/// Data object type string of response object.
///
@property(copy, nonatomic, nonnull) NSString  *object;
/// Page info for list objects.
///
@property(strong, nonatomic, nullable) id<JYPageObject> page;
/// Data for response.
///
@property(strong, nonatomic, nullable) id/*data:{string/dictionary}*/data;
@end

@interface JYResponseObject : NSObject <JYResponseObject>
/// Page info.
@property(strong, nonatomic, nullable) __kindof JYPageObject *page;
@end