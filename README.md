# YYRouter
YYRouter一个简单好用的swift路由组件



## 如何使用

pod 'YYRouter'



## 路由定义

```Sw
extension ViewController: YYRoutable {
    static func createInstance(params: [String : Any]) -> YYRoutable {
        return ViewController()
    }
}

extension YYRouter {
    @objc func router_ViewController() -> YYRouterModel {
        return YYRouterModel(to: "app://ViewController", routerClass: ViewController.self)
    }
}
```

## 路由调用

```Sw
YYRouter.pushTo(jumpParams: ["to": "app://ViewController"])
```


## 介绍
###  Swift路由组件（一）使用路由的目的和实现思想

https://juejin.cn/post/7032164814210203685/

### Swift路由组件（二）路由的实现

https://juejin.cn/post/7032214542528544805
