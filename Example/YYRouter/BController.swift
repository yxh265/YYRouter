//
//  BController.swift
//
//  Created by yxh265 on 2021/7/21.
//

import UIKit
import YYRouter
class BController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "B page"
        self.view.backgroundColor = .blue
        
        var button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle("跳 A 原生页面", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        self.view.addSubview(button)
        
        button = UIButton()
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        button.setTitle("跳 qq 网页", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        self.view.addSubview(button)
        
        button = UIButton()
        button.frame = CGRect(x: 100, y: 300, width: 200, height: 40)
        button.setTitle("跳 C 原生页面", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonAction3), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction1() {
        YYRouter.pushTo(jumpParams: ["to": "native://view/AController", "name": "1"])
    }
    @objc func buttonAction2() {
        YYRouter.pushTo(jumpParams: ["to": "https://www.qq.com", "value": "2"])
    }
    @objc func buttonAction3() {
        YYRouter.pushTo(jumpParams: ["to": "native://view/CController", "title": "定制跳转"])
    }
}

// 实现路由协议，让自己支持路由跳转。
extension BController: YYRoutable {
    // 返回一个路由协议的实例
    static func createInstance(params: [String : Any]) -> YYRoutable {
        return BController()
    }
}

// 添加路由表
extension YYRouter {
    @objc func router_BController() -> YYRouterModel {
        return YYRouterModel(to: "native://view/BController", routerClass: BController.self)
    }
}
