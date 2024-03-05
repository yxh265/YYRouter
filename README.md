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



## 路由调用的传参

这里负责传参

```Sw
YYRouter.pushTo(jumpParams: ["to": "app://ViewController", "param1": "1", "param2": 2])
```

 接收端负责接收

```Sw
extension ViewController: YYRoutable {
    static func createInstance(params: [String : Any]) -> YYRoutable {
        let vc = ViewController()
        vc.param1 = params["param1"] as? String ?? ""
        vc.param2 = params["param2"] as? Int ?? 0
        return vc
    }
}
```

 如果项目按模块组件开发，不同模块间都引入路由模块，那么A模块可以通过下面方法拿到B模块的某个类对象。

```Sw
let params = ["to": "app://ViewController", "param1": "1", "param2": 2]
if let vc = YYRouter.getRouterVC(jumpParams: params) {
    return vc // 通过路由跨模块拿到路由key："app://ViewController"的对象。
}
```



## 介绍

###  Swift路由组件（一）使用路由的目的和实现思想

https://juejin.cn/post/7032164814210203685/

### Swift路由组件（二）路由的实现

https://juejin.cn/post/7032214542528544805
