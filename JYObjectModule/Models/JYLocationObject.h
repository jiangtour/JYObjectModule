//
//  JYLocationObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/24.
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