//
//  NSObject+YSRouter.m
//  YSRouter
//
//  Created by yuan on 2018/6/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "NSObject+YSRouter.h"
#import <objc/runtime.h>

@implementation NSObject (YSRouter)

#pragma mark - *********** 调用类方法 ***********

- (id)sendClassEvents:(NSString *)eventName params:(NSArray *)paramArr{
    return [[self class] sendEvents:eventName params:paramArr isClass:YES];
}

- (id)sendInstanceEvents:(NSString *)eventName params:(NSArray *)paramArr{
    return [self sendEvents:eventName params:paramArr isClass:NO];
}

#pragma mark - *********** 调用实例方法 ***********

- (id)sendEvents:(NSString *)eventName params:(NSArray *)paramArr isClass:(BOOL)isClass{
    
    SEL selector = NSSelectorFromString(eventName);

    NSMethodSignature *methodSignature = [[self class] methodSignatureForSelector:selector];
    
    if (!isClass) {
        methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
    }
    
    if(methodSignature == nil)
    {
        if (DEBUG){
            NSString *desc = [NSString stringWithFormat:@"%@ 找不到 %@ 方法 ， 参数：%@",self,eventName,paramArr];
            @throw [NSException exceptionWithName:@"抛异常错误" reason:desc userInfo:nil];
        }
    }
    else
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        //签名中方法参数的个数，内部包含了self和_cmd，所以参数从第3个开始
        NSInteger  signatureParamCount = methodSignature.numberOfArguments - 2;
        NSInteger requireParamCount = paramArr.count;
        NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
        for (NSInteger i = 0; i < resultParamCount; i++) {
            id  obj = paramArr[i];
            [invocation setArgument:&obj atIndex:i+2];
        }
        [invocation invoke];
        //返回值处理
        id callBackObject = nil;
        if(methodSignature.methodReturnLength)
        {
            [invocation getReturnValue:&callBackObject];
        }
        
//        NSLog(@"执行结果：%@",callBackObject);
        
        return callBackObject;
    }
    return nil;
}

#pragma mark - *********** 设置属性 ***********

- (void)setPublicPragma:(NSString *)name pragma:(id)pragma{
    name = [@"_" stringByAppendingString:name];
    [self setPrivatePragma:name pragma:pragma];
}

- (void)setPrivatePragma:(NSString *)name pragma:(id)pragma{
    Ivar ivar = class_getInstanceVariable([self class], [name UTF8String]);
    object_setIvar(self, ivar, pragma);
}

#pragma mark - *********** 获取属性 ***********

- (id)getPublicPragma:(NSString *)name{
    name = [@"_" stringByAppendingString:name];
    return [self getPrivatePragma:name];
}

- (id)getPrivatePragma:(NSString *)name{
    Ivar ivar = class_getInstanceVariable([self class], [name UTF8String]);
    return object_getIvar(self, ivar);
}

@end
