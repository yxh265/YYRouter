//
//  ViewController.swift
//
//  Created by yxh265 on 2021/7/21.
//

import Foundation
import UIKit
import YYRouter
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle("跳 A 原生页面", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction1() {
        YYRouter.pushTo(jumpParams: ["to": "native://view/AController", "name": "1"])
    }
}
