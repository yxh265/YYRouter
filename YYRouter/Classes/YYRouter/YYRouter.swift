//
//  YYRouter.swift
//
//  Created by yxh265 on 2021/7/21.
//

import Foundation

public class YYRouter: NSObject {
    private static var shared = YYRouter()
    
    private static var routers: [String: YYRouterModel] = {
        return config()
    }()
#if DEBUG
    private static var isCheck: Bool = false
    private static var checkList: [String: Bool] = [:]
#endif
    
    private static func configRoutersFromMethodList() -> [String: YYRouterModel] {
        var routerList: [String: YYRouterModel] = [:]
        var methodCount: UInt32 = 0
        let methodList = class_copyMethodList(YYRouter.self, &methodCount)
         
        if let methodList = methodList, methodCount > 0 {
            for i in 0..<Int(methodCount) {
                let selName = sel_getName(method_getName(methodList[i]))
                if let methodName = String(cString: selName, encoding: .utf8),
                   methodName.hasPrefix("router_") {
                    let selector: Selector = NSSelectorFromString(methodName)
                    if YYRouter.shared.responds(to: selector) {
                        if let result = YYRouter.shared.perform(selector).takeUnretainedValue() as? YYRouterModel {
#if DEBUG
                            checkList["\(result.routerClass)"] = false
                            if routerList[result.to] != nil {
                                assert(false, "路由表重复了，请检查：\(result.to)。")
                            }
#endif
                            routerList[result.to] = result
                        }
                    }
                }
            }
        }
        free(methodList)
        return routerList
    }
#if DEBUG
    /// 自动检查所有的路由设置是否符合规范，当发现不符合规范的路由设置，直接中断
    private static func checkRoutableClassesSettingIsConform() {
        guard !isCheck else { return } // 只检查一次
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass>.allocate(capacity: Int(expectedClassCount))
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
        let actualClassCount: Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)

        for i in 0 ..< actualClassCount {
            let currentClass: AnyClass = allClasses[Int(i)]
            if (class_getInstanceMethod(currentClass, NSSelectorFromString("methodSignatureForSelector:")) != nil),
               (class_getInstanceMethod(currentClass, NSSelectorFromString("doesNotRecognizeSelector:")) != nil),
               let cls = currentClass as? YYRoutable.Type {
                var isSet = checkList["\(cls)"]
                if isSet == nil {
                    var curCls: AnyClass = cls as AnyClass
                    // 只要有一个父亲添加了路由表，就表示ok，因为路由那边是不允许子类实现路由协议的，子类只能继承，只能override，或者换别的类去实现路由
                    while let superCls = curCls.superclass() {
                        if checkList["\(superCls)"] != nil {
                            isSet = true
                            break
                        }
                        curCls = superCls
                    }
                }
                assert(isSet != nil, "\(cls)有实现Routable协议，但是没有添加路由表，或者路由表配置没有按规范，请检查：\(cls)。")
                checkList["\(cls)"] = true
            }
        }
        for (key, value) in checkList where value == false {
            assert(false, "\(key)有添加路由表，但是没有实现Routable协议，请检查：\(key)。")
        }
        isCheck = true
    }
#endif
    /// 配置映射文件
    private static func config() -> [String: YYRouterModel] {
        let routers = configRoutersFromMethodList()
#if DEBUG
        checkRoutableClassesSettingIsConform()
#endif
        return routers
    }
    
    private static func getRoutable(_ urlString: String, params: [String: Any]) -> YYRoutable? {
        guard let url = URL(string: urlString), let urlScheme = url.scheme else { return nil }
        var routerModel = routers[urlScheme]
        if routerModel == nil {
            let path = urlString.components(separatedBy: "?").first ?? ""
            routerModel = routers[path]
        }
        if let cls = routerModel?.routerClass, let routable = (cls as? YYRoutable.Type)?.createInstance(params: params) {
            return routable
        }
        return nil
    }
 
}

// MARK: - 路由入口
extension YYRouter {
    /// 路由处理逻辑:
    /// 从jumpParams取出to参数，得到url，通过url，转出routable。
    /// 最后跳转到routable和传参params
    public static func pushTo(jumpParams: [String: Any]? = nil, navRootVC: UIViewController? = nil) {
        let params = jumpParams ?? [:]
        guard let url = params["to"] as? String else {
            assert(false, "要跳转的路由链接不能空")
            return
        }
        
        guard let routable = getRoutable(url, params: params) else {
            assert(false, "路由实例不能为空")
            return
        }

        routable.executeRouter(params: params, navRootVC: navRootVC)
    }
}
