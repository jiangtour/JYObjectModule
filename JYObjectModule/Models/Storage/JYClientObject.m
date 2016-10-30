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
#import <objc/runtime.h>
#import <CocoaSecurity/CocoaSecurity.h>
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation JYClientObject
@synthesize objectId, userId, index, atUpdation, atCreation, descriptions, actived;

+ (void)load {
    [super load];
}

+ (Class)classForUserObjects {
    return JYUserObject.class;
}

+ (Class)classForClient {
    return self.class;
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
    // Get the client class.
    Class clsOfClient = [self classForClient];
    
    NSAssert(clsOfClient != NULL, @"Class for client can not be NULL.");
    NSAssert(!class_isMetaClass(clsOfClient), @"Class for client can not be Meta class.");
    Class superCls = clsOfClient;
    while (superCls != NULL && clsOfClient!=JYClientObject.class && !class_isMetaClass(superCls)) {
        if (class_conformsToProtocol(superCls, @protocol(JYClientObject))) {
            break;
        } else {
            superCls = class_getSuperclass(clsOfClient);
        }
    }
    NSAssert(class_conformsToProtocol(superCls, @protocol(JYClientObject)), @"Class for client must conforms to protocol <JYClientObject>.");
    
    // Find the actived client object from default realm.
    RLMResults *clientRes = [clsOfClient objectsWhere:@"actived = %@ AND index = 1", @(YES)];
    
    if (clientRes && clientRes.count == 1) {
        return [clientRes firstObject];
    }
    
    return nil;
}

+ (id<JYUserObject> _Nullable)activedUser {
    // Get the actived client.
    JYClientObject *activedClient = [self activedClient];
    
    // Get the user class.
    Class clsOfUser = [self classForUserObjects];
    
    NSAssert(clsOfUser != NULL, @"Class for user objects can not be NULL.");
    NSAssert(!class_isMetaClass(clsOfUser), @"Class for user objects can not be Meta class.");
    Class superCls = clsOfUser;
    while (superCls != NULL && clsOfUser!=JYUserObject.class && !class_isMetaClass(superCls)) {
        if (class_conformsToProtocol(superCls, @protocol(JYUserObject))) {
            break;
        } else {
            superCls = class_getSuperclass(clsOfUser);
        }
    }
    NSAssert(class_conformsToProtocol(superCls, @protocol(JYUserObject)), @"Class for client must conforms to protocol <JYUserObject>.");
    
    if (activedClient) {
        // Find actived user object from default realm.
        id<JYUserObject> user = [clsOfUser objectForPrimaryKey:activedClient.userId];
        
        return user;
    }
    
    return nil;
}

+ (void)activeClientWithUserId:(NSString * _Nonnull)userId {
    // Set client actived with user id.
    
    BOOL clientStored = NO;
    
    // Get the client class.
    Class clsOfClient = [self classForClient];
    
    NSAssert(clsOfClient != NULL, @"Class for client can not be NULL.");
    NSAssert(!class_isMetaClass(clsOfClient), @"Class for client can not be Meta class.");
    Class superCls = clsOfClient;
    while (superCls != NULL && clsOfClient!=JYClientObject.class && !class_isMetaClass(superCls)) {
        if (class_conformsToProtocol(superCls, @protocol(JYClientObject))) {
            break;
        } else {
            superCls = class_getSuperclass(clsOfClient);
        }
    }
    NSAssert(class_conformsToProtocol(superCls, @protocol(JYClientObject)), @"Class for client must conforms to protocol <JYClientObject>.");
    
    RLMResults *allClients = [clsOfClient allObjects];
    
    for (int i = 0; i < allClients.count; i++) {
        // Get client.
        JYRLMObject<JYClientObject> *client = allClients[i];
        
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
                client.actived = YES;
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
        JYRLMObject<JYClientObject> *client = [clsOfClient objectWithKeyValue:@{@"objectId":userId, @"userId":userId, @"index":@1, @"atUpdation":@([[NSDate date] timeIntervalSince1970]), @"atCreation":@([[NSDate date] timeIntervalSince1970]), @"actived":@1}];
        //
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:client];
        [realm commitWriteTransaction];
    }
}

+ (BOOL)unactiveClientWithUserId:(NSString * _Nonnull)userId {
    // Get the client class.
    Class clsOfClient = [self classForClient];
    
    NSAssert(clsOfClient != NULL, @"Class for client can not be NULL.");
    NSAssert(!class_isMetaClass(clsOfClient), @"Class for client can not be Meta class.");
    Class superCls = clsOfClient;
    while (superCls != NULL && clsOfClient!=JYClientObject.class && !class_isMetaClass(superCls)) {
        if (class_conformsToProtocol(superCls, @protocol(JYClientObject))) {
            break;
        } else {
            superCls = class_getSuperclass(clsOfClient);
        }
    }
    NSAssert(class_conformsToProtocol(superCls, @protocol(JYClientObject)), @"Class for client must conforms to protocol <JYClientObject>.");
    
    // Get client stored if exits.
    JYRLMObject<JYClientObject> *client = [clsOfClient objectForPrimaryKey:userId];
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

+ (NSString *)tokenForActivedClient {
    NSString *activedUserId = [self.activedClient userId];
    if (!activedUserId) return nil;
    return [UICKeyChainStore stringForKey:activedUserId];
}

+ (void)storeEtag:(NSString *)etag forEtagFlag:(NSString *)etagFlag {
    [UICKeyChainStore setString:etag forKey:[@"etag" stringByAppendingString:etagFlag]];
}

+ (NSString *)etagForEtagFlag:(NSString *)etagFlag {
    return [UICKeyChainStore stringForKey:[@"etag" stringByAppendingString:etagFlag]];
}
@end
