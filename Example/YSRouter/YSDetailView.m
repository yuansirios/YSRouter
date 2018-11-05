//
//  YSDetailView.m
//  YSRouter
//
//  Created by yuan on 2018/6/20.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSDetailView.h"

@implementation YSDetailView

- (instancetype)init{
    if (self == [super init]) {
        NSLog(@"YSDetailView init");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        NSLog(@"YSDetailView initWithFrame %@",NSStringFromCGRect(frame));
    }
    return self;
}

- (instancetype)initWithModel:(id)model{
    if (self == [super init]) {
        NSLog(@"YSDetailView initWithModel %@",model);
    }
    return self;
}

@end
