//
//  RLMRealm+Migration.m
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

#import "RLMRealm+Migration.h"

@implementation RLMRealm (Migration)
+ (uint64_t)schemaVersion {
    NSDictionary *configInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"_RLMRealmConfiguration" ofType:@"plist"]];
    uint64_t schemaVersion = [configInfo[@"schemaVersion"] integerValue];
    return schemaVersion;
}

+ (RLMMigrationBlock)migrationBlock {
    return
    [^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // 进行数据迁移
        NSLog(@"migration block called, oldSchemaVersion: %@", @(oldSchemaVersion));
        if (oldSchemaVersion < 1) {
            [migration enumerateObjects:@"MFPostUserObject" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"certifyState"] = @0;
            }];
            [migration enumerateObjects:@"MFPostObject" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"index"] = @0;
            }];
            [migration enumerateObjects:@"MFSpecialOfferObject" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"index"] = @0;
            }];
        }
        
    } copy];
}

+ (void)realmMigration {
    /*
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"realm"]];
    NSArray *realms = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSMutableSet *realmPaths = [NSMutableSet set];
    for (NSString *path in realms) {
        if ([path containsString:@"/"]) {
            [realmPaths addObject:[path stringByDeletingLastPathComponent]];
        }
    }
     */
    
    RLMRealmConfiguration *config_def_mig = [RLMRealmConfiguration defaultConfiguration];
    config_def_mig.schemaVersion = [self schemaVersion];
    config_def_mig.migrationBlock = [self migrationBlock];
    [RLMRealmConfiguration setDefaultConfiguration:config_def_mig];
    /*
    for (NSString *pa in realmPaths) {
        RLMRealmConfiguration *config_mig = [[RLMRealmConfiguration alloc] init];
        config_mig.path = [path stringByAppendingPathComponent:[pa stringByAppendingPathComponent:@"storage.realm"]];
        config_mig.schemaVersion = schemaVersion;
        config_mig.migrationBlock = migrationBlock;
    }
     */
}
@end