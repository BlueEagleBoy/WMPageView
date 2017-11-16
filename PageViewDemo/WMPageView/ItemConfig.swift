//
//  ItemConfig.swift
//  Vcard
//
//  Created by meng wang on 2017/11/14.
//  Copyright © 2017年 meng wang. All rights reserved.
//

import UIKit

enum kPageTitleStyle {
    //普通样式
    case normal
    //下hua线动画样式
    case textBottomLine
    //放大文案
    case enlargeText
}
class ItemConfig: NSObject {
    override init() {
    }
    //设置title数组
    public var titles:[String]?
    //传入控制器对象
    public var classes:[UIViewController]?
    //设置父类控制器
    public var superController:UIViewController?
    //设置pageview的样式
    public var style:kPageTitleStyle = kPageTitleStyle.normal
    //设置textAligment
    public var textAlignment:NSTextAlignment = NSTextAlignment.center
    
    //默认动画下划线的颜色
    public var textBottomLineColor:UIColor = UIColor.orange
    //设置item的默认颜色
    public var itemNormalColor:UIColor = UIColor.black
    //设置item的默认颜色
    public var itemSelectedColor:UIColor = UIColor.orange
    //设置title的背景色
    public var itemBackGroundColor:UIColor = UIColor.white
    
    //item宽度 width：0表示 按照文字自适应宽度
    public var itemWidth:CGFloat = 0.0
    //两边的间距
    public var padding:CGFloat = 10.0
    //文本之间的间距
    public var margin:CGFloat = 20.0
    //设置文本的font
    public var font:CGFloat = 14.0
    //设置title的高度
    public var itemHeight:CGFloat = 45.0
    //text下的bottomView
    public var textBottomLineHeight:CGFloat = 1.0
    
}
