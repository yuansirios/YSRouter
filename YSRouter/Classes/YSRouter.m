//
//  YSRouter.m
//  YSRouter
//
//  Created by yuan on 2018/6/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSRouter.h"

@implementation YSRouter

#pragma mark - *********** 获取实例 ***********

+ (id)getViewControllerInstance:(NSString *)className{
    id obj = [self getObjectInstance:className];
    if ([obj isKindOfClass:[UIViewController class]]){
        return obj;
    }
    return nil;
}

+ (id)getViewInstance:(NSString *)className{
    id obj = [self getObjectInstance:className];
    if ([obj isKindOfClass:[UIView class]]){
        return obj;
    }
    return nil;
}

+ (id)getObjectInstance:(NSString *)className{
    id obj = [[NSClassFromString(className) alloc]init];
    if (obj != nil){
        return obj;
    }
    return nil;
}

@end
