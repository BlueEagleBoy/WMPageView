//
//  TitleView.swift
//  Vcard
//
//  Created by meng wang on 2017/11/14.
//  Copyright © 2017年 meng wang. All rights reserved.
//

import UIKit

class WMPageView: UIView,UIScrollViewDelegate {

    public var itemConfig:ItemConfig? {
        didSet{
            assert(itemConfig!.titles?.count == itemConfig!.classes?.count, "titles count must isEqualt classes count")
            self.itemView.itemConfig = itemConfig
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initialUI() {
        self.addSubview(itemView)
        self.addSubview(self.scroll)
    }
    
    let screenWidth = UIScreen.main.bounds.size.width
    override func layoutSubviews() {
        super.layoutSubviews()
        if itemConfig == nil { return }
        self.itemView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: itemConfig!.itemHeight)
        self.scroll.frame = CGRect.init(x: 0, y: itemConfig!.itemHeight, width: self.frame.size.width, height: self.frame.size.height - itemConfig!.itemHeight)
       
        scroll.contentSize = CGSize.init(width: CGFloat(itemConfig!.classes!.count) * scroll.frame.size.width, height: 0)
    }
    
    private func selectedIndex(index:Int) {
        let vc = itemConfig?.classes![index]
        scroll.addSubview(vc!.view)
        if itemConfig!.superController != nil {
            itemConfig!.superController?.addChildViewController(vc!)
        }
        let offsetX:CGFloat = scroll.frame.size.width * CGFloat(index)
        vc!.view.frame = CGRect.init(x:offsetX, y: 0, width: self.frame.size.width, height: scroll.frame.size.height)
        scroll.setContentOffset(CGPoint.init(x:offsetX, y: 0), animated: true)
    }
    
    //MARK: - UIScollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        self.itemView.selectedIndex = Int(index)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        self.itemView.selectedIndex = Int(index)
    }
    
    //MARK: - lazy
    lazy var itemView: TitleHeaderView = {
        let titleView = TitleHeaderView.init()
        titleView.clickBlock = { (index:Int) ->() in
            self.selectedIndex(index: index)
        }
        return titleView
    }()
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView.init()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.delegate = self
        return scroll
    }()
}
