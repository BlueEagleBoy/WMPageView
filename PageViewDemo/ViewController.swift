//
//  ViewController.swift
//  PageViewDemo
//
//  Created by meng wang on 2017/11/15.
//  Copyright © 2017年 meng wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = ItemConfig.init()
        config.titles = ["测试1","测试2","测","测试4","测测试试","测试233","测测试试"]
        //传入控制器参数
        let testVc = TestViewController()
        testVc.parameter = "01234"
        
        config.classes = [testVc,TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController()]
        config.style = kPageTitleStyle.textBottomLine
        config.itemHeight = 40
        config.superController = self
        config.itemNormalColor = UIColor.orange
        config.itemSelectedColor = UIColor.red
        config.textBottomLineHeight = 2
        
        let pageView = WMPageView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64))
        pageView.itemConfig = config
        self.view.addSubview(pageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

