//
//  JYStringObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYStringObject <JYObject>
@required
/// Storage of string object.
///
@property(copy, nonatomic, nullable) NSString *storage;
@end

@interface JYStringObject : RLMObject <JYStringObject>
@end