//
//  JYIntegerObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYIntegerObject <JYObject>
@required
/// Integer value of integer object.
///
@property(assign, nonatomic) int64_t integer;
@end

@interface JYIntegerObject : RLMObject <JYIntegerObject>
@end