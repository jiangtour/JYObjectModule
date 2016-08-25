//
//  JYUserObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYObject.h"

@protocol JYUserObject <JYObject>
@required
/// Avatar url string of user.
///
@property(copy, nonatomic, nullable) NSString *avatar;
/// Nickname of user.
///
@property(copy, nonatomic, nullable) NSString *nickname;
/// Phone number of user.
///
@property(copy, nonatomic, nullable) NSString *phone;
/// Gender of user.
///
@property(assign, nonatomic) int64_t gender;
/// Birthday of user.
///
@property(copy, nonatomic, nullable) NSString *birthday;
@end
/// Gender definition of JYUserObject.
///
typedef NS_ENUM(int64_t, JYUserGender) {
    /// Not setting.
    JYUserGenderNone,
    /// Male.
    JYUserGenderMale,
    /// Female.
    JYUserGenderFemale
};

@interface JYUserObject : RLMObject <JYUserObject>
@end