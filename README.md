# YSRouter

[![Version](https://img.shields.io/cocoapods/v/YSRouter.svg?style=flat)](https://cocoapods.org/pods/YSRouter)
[![License](https://img.shields.io/cocoapods/l/YSRouter.svg?style=flat)](https://cocoapods.org/pods/YSRouter)
[![Platform](https://img.shields.io/cocoapods/p/YSRouter.svg?style=flat)](https://cocoapods.org/pods/YSRouter)


>自己YY的组件路由器，简单实现功能，供参考

## Contents
*   YSRouter
       * YSRouter.h
       * NSObject+YSRouter.h

## Installation

YSRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YSRouter'
```

## Author

yuansirios, yuansir_ios@163.com


## Question
这里有几个问题，希望大家帮我思考下

initWithFrame:调用有问题，CGRect不知道怎么传过去

```
UIView *view = [[YSRouter getViewInstance:@"YSDetailView"] sendInstanceEvents:@"initWithFrame:" params:@[]];

NSLog(@"%@",view.description);
```