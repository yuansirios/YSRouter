//
//  NSObject+YSRouter.h
//  RuntimeDemo
//
//  Created by 18336 on 2018/6/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSRouter)

#pragma mark - *********** 调用类方法 ***********

- (id)sendClassEvents:(NSString *)eventName params:(NSArray *)paramArr;

#pragma mark - *********** 调用实例方法 ***********

- (id)sendInstanceEvents:(NSString *)eventName params:(NSArray *)paramArr;

#pragma mark - *********** 设置属性 ***********

- (void)setPublicPragma:(NSString *)name pragma:(id)pragma;

- (void)setPrivatePragma:(NSString *)name pragma:(id)pragma;

#pragma mark - *********** 获取属性 ***********

- (id)getPublicPragma:(NSString *)name;

- (id)getPrivatePragma:(NSString *)name;

@end
