//
//  YSDetailViewController.m
//  YSRouter
//
//  Created by yuan on 2018/6/20.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSDetailViewController.h"

@interface YSDetailViewController (){
    UILabel *_contentLabel;
    NSString *_content;
    NSString *_privatePragma;
    NSString *privatePragma;
}

@end

@implementation YSDetailViewController

- (instancetype)init{
    if (self == [super init]) {
        _content = @"init";
    }
    return self;
}

- (instancetype)initWithArg:(NSString *)arg1 arg2:(NSString *)arg2{
    if (self == [super init]) {
        NSString *msg = [NSString stringWithFormat:@"initWithArg \n arg1:%@ \n arg2:%@",arg1,arg2];
        _content = msg;
    }
    return self;
}

- (instancetype)initWithArg:(NSString *)arg1 block:(testBlock)block{
    if (self == [super init]) {
        NSString *msg = [NSString stringWithFormat:@"initWithArg \n arg1:%@ \n block:%@",arg1,block];
        _content = msg;
        block(msg);
    }
    return self;
}

#pragma mark - *********** 实例方法 ***********

- (void)showContent{
    NSLog(@"showContent");
}

- (NSString *)showContent:(NSString *)arg{
    NSString *msg = [NSString stringWithFormat:@"showContent \n arg:%@",arg];
    NSLog(@"%@",msg);
    return msg;
}

- (void)showContent:(NSString *)arg arg2:(NSString *)arg2{
    NSString *msg = [NSString stringWithFormat:@"showContent \n arg:%@ arg2:%@",arg,arg2];
    NSLog(@"%@",msg);
}

#pragma mark - *********** 类方法 ***********

+ (void)showClassContent{
    NSLog(@"showClassContent");
}

+ (NSString *)showClassContent:(NSString *)arg{
    NSString *msg = [NSString stringWithFormat:@"showClassContent \n arg:%@",arg];
    NSLog(@"%@",msg);
    return msg;
}

+ (void)showClassContent:(NSString *)arg arg2:(NSString *)arg2{
    NSString *msg = [NSString stringWithFormat:@"showClassContent \n arg:%@ \n arg:%@",arg,arg2];
    NSLog(@"%@",msg);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _contentLabel = [UILabel new];
    [_contentLabel setBackgroundColor:[UIColor greenColor]];
    [_contentLabel setFrame:CGRectMake(0, 50, 200, 40)];
    [_contentLabel setFont:[UIFont systemFontOfSize:20]];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    [self.view addSubview:_contentLabel];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_contentLabel setText:_content];
    [_contentLabel sizeToFit];
    _contentLabel.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
