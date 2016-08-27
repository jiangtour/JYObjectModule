//
//  ViewController.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/23.
//  Copyright © 2016年 jiangyou. All rights reserved.
//

#import "ViewController.h"
#import "JYObject.h"
#import "JYImageObject.h"
#import "JYBannerObject.h"
#import "JYCommentObject.h"
#import <objc/runtime.h>

#import "PostObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    JYObject *object = [JYObject new];
    object.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970])];
    
    NSLog(@"path : %@", realm.configuration.fileURL.absoluteString);
    JYImageObject *image = [JYImageObject new];
    image.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+1)];
    image.url = @"http://www.baidu.com";
    JYUserObject *user = [JYUserObject new];
    user.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+2)];
    user.nickname = @"devedbox";
    JYCommentObject *comment = [JYCommentObject new];
    comment.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+3)];
    [comment.images addObject:image];
    comment.user = user;
    comment.atUser = user;
    
    UserObject *_user = [UserObject new];
    _user.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+4)];
    _user.test = @"hhh";
    _user.nickname = @"UserObject";
    PostObject *_post = [PostObject new];
    _post.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+5)];
    _post.title = @"PostObject";
    _post.user = _user;
    JYPostObject *post = [JYPostObject new];
    post.objectId = [NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970]+6)];
    post.user = _user;
    post.title = @"JYRLMPostObject";
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:object];
    [realm addOrUpdateObject:image];
    [realm addOrUpdateObject:user];
    [realm addOrUpdateObject:comment];
    [realm addOrUpdateObject:_user];
    [realm addOrUpdateObject:_post];
    [realm addOrUpdateObject:post];
    [realm commitWriteTransaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end