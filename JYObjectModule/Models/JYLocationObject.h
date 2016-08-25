//
//  JYLocationObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYLocationObject <JYObject>
@required
/// Longitude of location.
///
@property(assign, nonatomic) double longitude;
/// Latitude of location.
///
@property(assign, nonatomic) double latitude;
/// Province name.
///
@property(copy, nonatomic, nullable) NSString *province;
/// City name.
///
@property(copy, nonatomic, nullable) NSString *city;
/// District name.
///
@property(copy, nonatomic, nullable) NSString *district;
/// Street name.
///
@property(copy, nonatomic, nullable) NSString *street;
/// Address discription.
///
@property(copy, nonatomic, nullable) NSString *address;
@end

@interface JYLocationObject : RLMObject <JYLocationObject>
@end