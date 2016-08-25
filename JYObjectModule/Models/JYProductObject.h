//
//  JYProductObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"
#import "JYImageObject.h"
#import "JYIntegerObject.h"
#import "JYProductCategoryObject.h"

@protocol JYProductObject <JYObject>
@required
/// State of product object.
///
@property(assign, nonatomic) int64_t state;
/// Substate of product object.
///
@property(assign, nonatomic) int64_t substate;
/// Product detail url of product object.
///
@property(copy, nonatomic, nullable) NSString *url;
/// Title of product object.
///
@property(copy, nonatomic, nullable) NSString *title;
/// Detail of product object.
///
@property(copy, nonatomic, nullable) NSString *detail;
/// Thumbnail url of product object.
///
@property(copy, nonatomic, nullable) NSString *thumbnail;
/// Images of product object.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYImageObject *><JYImageObject> *images;
/// Characteristics of product object.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYIntegerObject *><JYIntegerObject> *characteristics;
/// Categories of product object.
///
@property(strong, nonatomic, nullable) RLMArray<__kindof JYProductCategoryObject *><JYProductCategoryObject> *categories;
@end

@interface JYProductObject : RLMObject <JYProductObject>
@end