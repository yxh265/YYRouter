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

