//
//  JYProductObject.h
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
#import "JYImageObject.h"
#import "JYIntegerObject.h"
#import "JYProductCategoryObject.h"
#import "JYProductSpecificationObject.h"
#import "JYProductSpecificationGroupObject.h"
/*!
 *  Product object protocol.
 */
@protocol JYProductObject <JYObject>
@required
/*!
 *  State of product object.
 */
@property(assign, nonatomic) int64_t state;
/*!
 *  Substate of product object.
 */
@property(assign, nonatomic) int64_t substate;
/*!
 *  Characteristics of product object.
 */
@property(assign, nonatomic) int64_t characteristics;
/*!
 *  Product detail url of product object.
 */
@property(copy, nonatomic, nullable) NSString *url;
/*!
 *  Title of product object.
 */
@property(copy, nonatomic, nullable) NSString *title;
/*!
 *  Detail of product object.
 */
@property(copy, nonatomic, nullable) NSString *detail;
/*!
 *  Thumbnail url of product object.
 */
@property(copy, nonatomic, nullable) NSString *thumbnail;
/*!
 *  Images of product object.
 */
@property(strong, nonatomic, nullable) RLMArray<JYImageObject> *images;
/*!
 *  Categories of product object.
 */
@property(strong, nonatomic, nullable) RLMArray<JYProductCategoryObject> *categories;
/**
 Specifications of product.
 */
@property(strong, nonatomic, nullable) RLMArray<JYProductSpecificationObject> *specifications;
/**
 Specification groups of product.
 */
@property(strong, nonatomic, nullable) RLMArray<JYProductSpecificationGroupObject> *specificationGroups;
@end
/*!
 *  JYProductObject.
 */
@interface JYProductObject : JYRLMObject <JYProductObject>
/*!
 *  Images of product object.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYImageObject *><JYImageObject> *images;
/*!
 *  Categories of product object.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYProductCategoryObject *><JYProductCategoryObject> *categories;
/**
 Specifications of product.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYProductSpecificationObject*><JYProductSpecificationObject> *specifications;
/**
 Specification groups of product.
 */
@property(strong, nonatomic, nullable) RLMArray<__kindof JYProductSpecificationGroupObject*><JYProductSpecificationGroupObject> *specificationGroups;
@end
