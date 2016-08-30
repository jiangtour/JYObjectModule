//
//  JYClientUserObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/29.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "JYClientObject.h"
#import "RLMObject+KeyValue.h"
#import <Realm/Realm.h>
#import <CocoaSecurity/CocoaSecurity.h>
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation JYClientObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, actived;

+ (void)load {
    [super load];
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    return [super indexedProperties];
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    return [super defaultPropertyValues];
}
+ (nullable NSString *)primaryKey
{
    return [super primaryKey];
}
+ (nullable NSArray *)ignoredProperties
{
    return [super ignoredProperties];
}
+ (NSArray *)requiredProperties
{
    return [super requiredProperties];
}

#pragma mark - Public interface
+ (instancetype _Nullable)activedClient {
    // Find the actived client object from default realm.
    RLMResults *clientRes = [JYClientObject objectsWhere:@"actived = %@", @(YES)];
    
    if (clientRes && clientRes.count == 1) {
        return [clientRes firstObject];
    }
    
    return nil;
}

+ (id<JYUserObject> _Nullable)activedUser {
    // Get the actived client.
    JYClientObject *activedClient = [self activedClient];
    
    if (activedClient) {
        // Find actived user object from default realm.
        JYUserObject *user = [JYUserObject objectForPrimaryKey:activedClient.userId];
        
        return user;
    }
    
    return nil;
}

+ (void)activeClientWithUserId:(NSString * _Nonnull)userId {
    // Set client actived with user id.
    
    BOOL clientStored = NO;
    
    RLMResults *allClients = [JYClientObject allObjects];
    
    for (int i = 0; i < allClients.count; i++) {
        // Get client.
        JYClientObject *client = allClients[i];
        
        if ([client.userId isEqualToString:userId] && [client.objectId isEqualToString:userId]) {
            // Client is stored.
            clientStored = YES;
            
            if (client.actived && client.index == 1) {
                // Client actived.
                [client.realm beginWriteTransaction];
                client.atUpdation = [[NSDate date] timeIntervalSince1970];
                [client.realm commitWriteTransaction];
            } else {
                [client.realm beginWriteTransaction];
                clientStored = YES;
                client.index = 1;
                client.atUpdation = [[NSDate date] timeIntervalSince1970];
                [client.realm commitWriteTransaction];
            }
            
        } else {
            [client.realm beginWriteTransaction];
            client.actived = NO;
            client.index = 0;
            client.atUpdation = [[NSDate date] timeIntervalSince1970];
            [client.realm commitWriteTransaction];
        }
    }
    
    if (!clientStored) {
        // Create a new client object.
        JYClientObject *client = [JYClientObject objectWithKeyValue:@{@"objectId":userId, @"userId":userId, @"index":@1, @"atUpdation":@([[NSDate date] timeIntervalSince1970]), @"atCreation":@([[NSDate date] timeIntervalSince1970]), @"actived":@1}];
        //
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:client];
        [realm commitWriteTransaction];
    }
}

+ (BOOL)unactiveClientWithUserId:(NSString * _Nonnull)userId {
    // Get client stored if exits.
    JYClientObject *client = [JYClientObject objectForPrimaryKey:userId];
    // unactive client if client object exits in realm.
    if (client) {
        [client.realm beginWriteTransaction];
        client.actived = NO;
        client.index = 0;
        client.atUpdation = [[NSDate date] timeIntervalSince1970];
        [client.realm commitWriteTransaction];
        return YES;
    }
    return NO;
}

+ (void)storeClientTokenWithToken:(NSString *)token {
    // Check token.
    NSAssert(token, @"When store token value of client, client token cannot be nil.");
    // Store the token with actived user id.
    [UICKeyChainStore setString:token forKey:[self.activedClient userId]];
}

+ (void)storeEtag:(NSString *)etag forEtagFlag:(NSString *)etagFlag {
    [UICKeyChainStore setString:etag forKey:[@"etag" stringByAppendingString:etagFlag]];
}

+ (NSString *)etagForEtagFlag:(NSString *)etagFlag {
    return [UICKeyChainStore stringForKey:[@"etag" stringByAppendingString:etagFlag]];
}
@end