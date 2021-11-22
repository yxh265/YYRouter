//
//  YYRouterModel.swift
//
//  Created by yxh265 on 2021/7/21.
//

import Foundation

public class YYRouterModel: NSObject {
    /// 路由名，可以任意定义一个唯一的key
    /// 如：native://course/detail,这样的一个规则表示本地的某个页面。
    /// 或者http，或者https，这两个表示是url网页，直接用webview去响应。
    public var to: String = ""
    public var routerClass: AnyClass = YYRouterModel.self // 路由目标类
    
    /// 路由模块的路由表定义
    /// - Parameters:
    ///   - to: 路由名的定义
    ///   - routerClass: 路由目标类
    public convenience init(to: String, routerClass: AnyClass) {
        self.init()
        self.to = to
        self.routerClass = routerClass
    }
}
