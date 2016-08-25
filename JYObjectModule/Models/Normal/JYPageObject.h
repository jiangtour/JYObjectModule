//
//  JYPageObject.h
//  JYObjectModule
//
//  Created by devedbox on 16/8/25.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JYPageObject <NSObject>
@required
/// Index of current page.
///
@property(assign, nonatomic) int64_t index;
/// Count of items per page.
///
@property(assign, nonatomic) int64_t pageCount;
/// Total count of all object in the pages.
///
@property(assign, nonatomic) int64_t totalCount;
@end

@interface JYPageObject : NSObject <JYPageObject>
@end