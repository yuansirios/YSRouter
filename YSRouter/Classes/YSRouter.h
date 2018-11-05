//
//  YSRouter.h
//  YSRouter
//
//  Created by yuan on 2018/6/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NSObject+YSRouter.h"

@interface YSRouter : NSObject

#pragma mark - *********** 获取实例 ***********

+ (id)getViewControllerInstance:(NSString *)className;

+ (id)getViewInstance:(NSString *)className;

@end
