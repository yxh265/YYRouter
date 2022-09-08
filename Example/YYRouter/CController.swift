//
//  CController.swift
//  YYRouter_Example
//
//  Created by yxh265 on 2022/9/8.
//

import UIKit
import YYRouter

class CController: UIViewController {
    var titleString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleString
        self.view.backgroundColor = .yellow
 
    }
}

// 实现路由协议，让自己支持路由跳转。
extension CController: YYRoutable {
    // 返回一个路由协议的实例
    static func createInstance(params: [String : Any]) -> YYRoutable {
        return CController()
    }
    
    // 如果有特殊逻辑，可以自己实现路由做特殊跳转
    func executeRouter(params: [String: Any] = [:], navRootVC: UIViewController? = nil) {
        print("====跳转逻辑自己写")
        let controller = CController()
        controller.titleString = params["title"] as? String ?? "" // 路由传参数

        if navRootVC?.navigationController != nil {
            navRootVC?.navigationController?.pushViewController(controller, animated: true)
        } else {
            YYRouterUtil.currentNavigationController()?.pushViewController(controller, animated: true)
        }
    }
}

// 添加路由表
extension YYRouter {
    @objc func router_CController() -> YYRouterModel {
        return YYRouterModel(to: "native://view/CController", routerClass: CController.self)
    }
}
