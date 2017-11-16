//
//  TestViewController.swift
//  PageViewDemo
//
//  Created by meng wang on 2017/11/15.
//  Copyright © 2017年 meng wang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    public var parameter:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1)
        if let parameStr = parameter {
            print("测试控制器" + "传入的参数：" + parameStr)
        }else {
            print("测试控制器")
        }
    }
}
