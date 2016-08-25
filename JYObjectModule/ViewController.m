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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JYObject *object = [JYObject new];
    object.objectId = @"sanpaopajpaojsdaopjdapojda";
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"path : %@", realm.configuration.fileURL.absoluteString);
    JYImageObject *image = [JYImageObject new];
    image.url = @"http://www.baidu.com";
    JYUserObject *user = [JYUserObject new];
    user.nickname = @"devedbox";
    user.objectId = @"862099730";
    JYCommentObject *comment = [JYCommentObject new];
    [comment.images addObject:image];
    comment.user = user;
    comment.atUser = user;
    [realm beginWriteTransaction];
    [realm addObject:object];
    [realm addObject:image];
    [realm addObject:user];
    [realm addObject:comment];
    [realm commitWriteTransaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end