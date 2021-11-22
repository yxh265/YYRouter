//
//  WebController.swift
//
//  Created by yxh265 on 2021/11/17.
//

import UIKit
import WebKit
import YYRouter

class WebController: UIViewController {
    var webView: WKWebView!
    var url: String = ""
    var value: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Web"
        self.view.backgroundColor = .white
        
        webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
        self.view.addSubview(webView!)
        if let requestUrl = URL(string: self.url) {
            var request: URLRequest = URLRequest(url: requestUrl)
            request.timeoutInterval = 60
            webView.load(request)
        }
    }
}

// 实现路由协议，让自己支持路由跳转。
extension WebController: YYRoutable {
    // 返回一个路由协议的实例
    static func createInstance(params: [String : Any]) -> YYRoutable {
        let vc = WebController()
        vc.url = params["to"] as? String ?? "" // 路由传参数
        vc.value = params["value"] as? String ?? "" // 路由传参数
        return vc
    }
}

// 添加路由表
extension YYRouter {
    @objc func router_WebController() -> YYRouterModel {
        return YYRouterModel(to: "http", routerClass: WebController.self)
    }
    @objc func router_WebController_https() -> YYRouterModel {
        return YYRouterModel(to: "https", routerClass: WebController.self)
    }
}
