//
//  YYRoutable.swift
//
//  Created by yxh265 on 2021/7/21.
//

import Foundation

/// 路由协议, 需要是AnyObject，其他如struct和enum等不能实现这个协议
public protocol YYRoutable: AnyObject {
    /// 路由传参，接收者负责解析自己的参数并返回一个路由实例
    static func createInstance(params: [String: Any]) -> YYRoutable

    /// 路由逻辑处理
    func executeRouter(params: [String: Any], navRootVC: UIViewController?)
}

/// 路由协议的默认实现
public extension YYRoutable {
    /// 默认路由跳转
    func executeRouter(params: [String: Any] = [:], navRootVC: UIViewController? = nil) {
        guard let controller = self as? UIViewController else {
            assert(false, "默认路由跳转，需要routable继承UIViewController")
            return
        }
        
        defaultPush(to: controller, params: params, navRootVC: navRootVC)
    }
}

/// 路由里面的私有方法
public extension YYRoutable {
    /// native://my?userId=1&token=jdfsakbfjkafbf
    ///
    /// - Parameters:
    ///   - controller: 跳转VC
    ///   - params: 额外参数
    ///   - navRootVC 有的时候不需要取currentVC
    func defaultPush(to controller: UIViewController, params: [String: Any] = [:], navRootVC: UIViewController? = nil) {
        let animated = (params["animated"] as? Bool) ?? true
        let hidesBottomBarWhenPushed = (params["hidesBottomBarWhenPushed"] as? Bool) ?? true
        
        if let rootVC = YYRouterUtil.getNavigationController(navRootVC: navRootVC) {
            controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
            rootVC.pushViewController(controller, animated: animated)
        }
    }
}
