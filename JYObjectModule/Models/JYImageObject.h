//
//  JYImageObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYImageObject <JYObject>
@required
/// Url string of remote image resource.
///
@property(copy, nonatomic, nonnull) NSString *url;
@end

@interface JYImageObject : RLMObject <JYImageObject>
@end