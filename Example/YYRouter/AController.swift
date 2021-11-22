//
//  AController.swift
//
//  Created by yxh265 on 2021/7/21.
//

import UIKit
import YYRouter
class AController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "A page"
        self.view.backgroundColor = .green
        
        var button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle("跳 B 原生页面", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        self.view.addSubview(button)
        
        button = UIButton()
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        button.setTitle("跳 baidu 网页", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction1() {
        YYRouter.pushTo(jumpParams: ["to": "native://view/BController", "name": "1"])
    }
    @objc func buttonAction2() {
        YYRouter.pushTo(jumpParams: ["to": "https://www.baidu.com", "value": "2"])
    }
}

// 实现路由协议，让自己支持路由跳转。
extension AController: YYRoutable {
    // 返回一个路由协议的实例
    static func createInstance(params: [String : Any]) -> YYRoutable {
        return AController()
    }
    
    // 如果有特殊逻辑，可以自己实现路由做特殊跳转
//    func executeRouter(params: [String: Any] = [:], navRootVC: UIViewController? = nil) {
//
//    }
}

// 添加路由表
extension YYRouter {
    @objc func router_AController() -> YYRouterModel {
        return YYRouterModel(to: "native://view/AController", routerClass: AController.self)
    }
}
