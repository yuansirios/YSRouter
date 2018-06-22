//
//  YSViewController.m
//  YSRouter
//
//  Created by yuansirios on 06/20/2018.
//  Copyright (c) 2018 yuansirios. All rights reserved.
//

#import "YSViewController.h"

@interface YSViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_dataArr;
    id vcObj;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"YSRouter";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
    
    [self loadSource];
    
    vcObj = [YSRouter getViewControllerInstance:@"YSDetailViewController"];
}

- (void)loadSource{
    _dataArr = @[
                 @{@"title":@"实例对象",
                   @"list":
                       @[
                           @{@"title":@"控制器实例",@"event":@"testViewControllerInstance"},
                           @{@"title":@"视图实例",@"event":@"testViewInstance"},
                           @{@"title":@"自定义构造函数",@"event":@"testCustomClass"},
                           @{@"title":@"带block的构造函数",@"event":@"testBlockInit"}
                        ]
                   },
                 @{@"title":@"实例对象调用方法",
                   @"list":
                       @[
                           @{@"title":@"单个参数",@"event":@"testInstanceSinglePragma"},
                           @{@"title":@"多个参数",@"event":@"testInstanceMutablePragma"}
                        ]
                   },
                 @{@"title":@"类方法调用",
                   @"list":
                       @[
                           @{@"title":@"单个参数",@"event":@"testClassSinglePragma"},
                           @{@"title":@"多个参数",@"event":@"testClassMutablePragma"}
                        ]
                   },
                 @{@"title":@"设置属性",
                   @"list":
                       @[
                           @{@"title":@"设置公共属性",@"event":@"testWritePublicPragma"},
                           @{@"title":@"设置私有属性",@"event":@"testWritePrivatePragma"},
                           @{@"title":@"获取公共属性",@"event":@"testReadPublicPragma"},
                           @{@"title":@"获取私有属性",@"event":@"testReadPrivatePragma"}
                        ]
                   }
                 ];

}

- (void)viewDidLayoutSubviews{
    [_tableView reloadData];
}

#pragma mark - UITableView methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = _dataArr[section][@"title"];
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *listArr = _dataArr[section][@"list"];
    return listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
    }
    
    NSArray *listArr = _dataArr[indexPath.section][@"list"];
    NSDictionary *listDic = listArr[indexPath.row];
    cell.textLabel.text = listDic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *listArr = _dataArr[indexPath.section][@"list"];
    NSDictionary *listDic = listArr[indexPath.row];
    NSString *event = listDic[@"event"];
    
    SEL selector = NSSelectorFromString(event);
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
}

#pragma mark - *********** 实例对象 ***********
//TODO:控制器实例
- (void)testViewControllerInstance{
    //YSDetailViewController *vc = [[YSDetailViewController alloc]init];
    UIViewController *vc = [YSRouter getViewControllerInstance:@"YSDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

//TODO:视图实例
- (void)testViewInstance{
    UIView *view = [YSRouter getViewInstance:@"YSDetailView"];
    [view setFrame:CGRectMake(0, 0, 100, 100)];
    NSLog(@"%@",view.description);
    
    CGRect rect = CGRectMake(20, 20, 50, 50);
    
    //initWithFrame:调用有问题，CGRect无法传值过去，
    UIView *view2 = [[YSRouter getViewInstance:@"YSDetailView"] sendInstanceEvents:@"initWithFrame:" params:@[[NSValue valueWithCGRect:rect]]];
    NSLog(@"%@",view2.description);
    
    UIView *view3 = [[YSRouter getViewInstance:@"YSDetailView"] sendInstanceEvents:@"initWithModel:" params:@[@"123"]];
    NSLog(@"%@",view3.description);
}

//TODO:自定义构造函数
- (void)testCustomClass{
    //YSDetailViewController *vc = [[YSDetailViewController alloc]initWithArg:@"111111111" arg2:@"222222222"];
    UIViewController *vc = [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendInstanceEvents:@"initWithArg:arg2:" params:@[@"1111111111",@"222222222"]];
    [self.navigationController pushViewController:vc animated:YES];
}

//TODO:带block的构造函数
- (void)testBlockInit{
    //YSDetailViewController *vc = [[YSDetailViewController alloc]initWithArg:@"111" block:^(NSString *string) { }];
    void (^testBlock)(NSString *str) = ^(NSString *str) {
        NSLog(@"str:%@",str);
    };
    UIViewController *vc = [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendInstanceEvents:@"initWithArg:block:" params:@[@"1111111111",testBlock]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - *********** 实例对象调用方法 ***********
//单个参数
- (void)testInstanceSinglePragma{
    [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendInstanceEvents:@"showContent" params:nil];
}

//多个参数
- (void)testInstanceMutablePragma{
    NSString *msg = [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendInstanceEvents:@"showContent:" params:@[@"11111"]];
    NSLog(@"%@",msg);
    
    [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendInstanceEvents:@"showContent:arg2:" params:@[@"11111",@"22222"]];
}

#pragma mark - *********** 类方法调用 ***********

- (void)testClassSinglePragma{
    [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendClassEvents:@"showClassContent" params:nil];
}

- (void)testClassMutablePragma{

    NSString *msg = [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendClassEvents:@"showClassContent:" params:@[@"111111"]];
    NSLog(@"%@",msg);
    
    [[YSRouter getViewControllerInstance:@"YSDetailViewController"] sendClassEvents:@"showClassContent:arg2:" params:@[@"11111",@"22222"]];
}

#pragma mark - *********** 设置属性 ***********

//TODO:设置公共属性
- (void)testWritePublicPragma{
    [vcObj setPublicPragma:@"publicPragma" pragma:@"123123"];
}

//TODO:设置私有属性
- (void)testWritePrivatePragma{
    [vcObj setPrivatePragma:@"_privatePragma" pragma:@"111111"];
    [vcObj setPrivatePragma:@"privatePragma" pragma:@"222222"];
}

//TODO:获取公共属性
- (void)testReadPublicPragma{
    NSString *str = [vcObj getPublicPragma:@"publicPragma"];
    NSLog(@"公共属性:%@",str);
}

//TODO:获取私有属性
- (void)testReadPrivatePragma{
    NSString *str = [vcObj getPrivatePragma:@"_privatePragma"];
    NSString *str1 = [vcObj getPrivatePragma:@"privatePragma"];
    NSLog(@"私有属性:%@:%@",str,str1);
}

#pragma mark - *********** get & set ***********

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}

@end
