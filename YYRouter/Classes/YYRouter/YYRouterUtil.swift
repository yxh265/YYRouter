//
//  YYRouterUtil.swift
//
//  Created by yxh265 on 2021/7/21.
//

import Foundation

public struct YYRouterUtil {
    public static func delegate() -> UIApplicationDelegate {
        return UIApplication.shared.delegate!
    }

    public static func currentController() -> UIViewController {
        if let root = delegate().window??.rootViewController {
            return getCurrent(controller: root)
        } else {
            print("异常问题, 还没有rootVC不应该调用")
            assert(false, "异常问题, 还没有rootVC不应该调用")
            return UIViewController()
        }
    }

    /// 当前的导航控制器
    public static func currentNavigationController() -> UINavigationController? {
        return currentController().navigationController
    }
    
    /// 获取可用的导航控制器
    public static func getNavigationController(navRootVC: UIViewController? = nil) -> UINavigationController? {
        if let rootVC = navRootVC as? UINavigationController {
            return rootVC
        } else if let rootVC = navRootVC?.navigationController {
            return rootVC
        } else {
            return currentNavigationController()
        }
    }
    
    /// 通过递归拿到当前显示的UIViewController
    public static func getCurrent(controller: UIViewController) -> UIViewController {
        if controller is UINavigationController {
            let naviController = controller as! UINavigationController
            return getCurrent(controller: naviController.viewControllers.last!)
        } else if controller is UITabBarController {
            let tabbarController = controller as! UITabBarController
            return getCurrent(controller: tabbarController.selectedViewController!)
        } else if controller.presentedViewController != nil {
            return getCurrent(controller: controller.presentedViewController!)
        } else {
            return controller
        }
    }
}
