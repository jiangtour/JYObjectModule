//
//  JYProductCategoryObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYChainObject.h"

@protocol JYProductCategoryObject <JYChainObject>
@required
@end

@interface JYProductCategoryObject : RLMObject <JYProductCategoryObject>
@end