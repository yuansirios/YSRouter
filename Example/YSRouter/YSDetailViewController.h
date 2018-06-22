//
//  YSDetailViewController.h
//  YSRouter
//
//  Created by 18336 on 2018/6/20.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^testBlock)(NSString *string);

@interface YSDetailViewController : UIViewController

@property (nonatomic,copy) NSString *publicPragma;

- (instancetype)initWithArg:(NSString *)arg1 arg2:(NSString *)arg2;

- (instancetype)initWithArg:(NSString *)arg1 block:(testBlock)block;

#pragma mark - *********** 实例方法 ***********

- (void)showContent;

- (NSString *)showContent:(NSString *)arg;

- (void)showContent:(NSString *)arg arg2:(NSString *)arg2;

#pragma mark - *********** 类方法 ***********

+ (void)showClassContent;

+ (NSString *)showClassContent:(NSString *)arg;

+ (void)showClassContent:(NSString *)arg arg2:(NSString *)arg2;

@end
