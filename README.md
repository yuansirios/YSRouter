# YSRouter

>自己YY的组件路由器，简单实现功能，供参考

这里有几个问题，希望大家帮我思考下

initWithFrame:调用有问题，CGRect不知道怎么传过去

```
UIView *view = [[YSRouter getViewInstance:@"YSDetailView"] sendInstanceEvents:@"initWithFrame:" params:@[]];

NSLog(@"%@",view.description);
```