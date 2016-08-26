//
//  JYNullObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/26.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JYNullObject <NSObject>
@end

@interface JYNullObject : NSObject <JYNullObject>
@end