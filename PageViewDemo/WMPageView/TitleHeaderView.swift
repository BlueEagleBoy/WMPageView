//
//  TitleHeaderView.swift
//  Vcard
//
//  Created by meng wang on 2017/11/14.
//  Copyright © 2017年 meng wang. All rights reserved.
//

import UIKit

class TitleHeaderView: UIView {
    
    var lastItem:UIButton?
    var items:[UIButton]?
    public var clickBlock: ((Int)->())?
    public var selectedIndex:Int? {
        didSet {
            self.click(sender: items![selectedIndex!])
        }
    }
    public var itemConfig:ItemConfig? {
        didSet {
            self.setupItem()
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
        self.addSubview(self.scroll)
    }
    
    func setupItem() {
        items = NSMutableArray.init() as? [UIButton]
        assert(itemConfig!.titles != nil, "it's must has titles")
        var index:Int = 0
        for str in itemConfig!.titles!{
            if str.lengthOfBytes(using:.utf8) == 0 {continue}
            let button = UIButton.init()
            button.setTitleColor(itemConfig!.itemNormalColor, for: UIControlState.normal)
            button.setTitleColor(itemConfig!.itemSelectedColor, for: UIControlState.selected)
            button.titleLabel!.textAlignment = itemConfig!.textAlignment
            button.setTitle(str, for: UIControlState.normal)
            button.titleLabel!.font = UIFont.systemFont(ofSize: itemConfig!.font)
            button.tag = index
            button.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            items!.append(button)
            scroll.addSubview(button)
            if index == 0 {
                button.isSelected = true
                lastItem = button
                if clickBlock != nil {
                    self.clickBlock!(index)
                }
            }
            index += 1
        }
        
        if itemConfig!.style == kPageTitleStyle.textBottomLine {
            self.bottomLine.backgroundColor = itemConfig!.textBottomLineColor
            scroll.addSubview(self.bottomLine)
        }
        self.backgroundColor = itemConfig!.itemBackGroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scroll.frame = self.bounds
        assert(itemConfig != nil, "no itemconfig")
        if items == nil || items?.count == 0 {return}
        var itemX:CGFloat = itemConfig!.padding
        for index in 0..<itemConfig!.titles!.count {
            let button = items![index]
            var itemWidth =  itemConfig!.itemWidth
            if itemWidth == 0 {
                itemWidth = width(with: button.title(for: .normal)!, height: button.titleLabel!.font.lineHeight, font: button.titleLabel!.font) + itemConfig!.margin
//                itemWidth =  button.title(for: UIControlState.normal)!.width(with: button.titleLabel!.font.lineHeight, font: button.titleLabel!.font) + itemConfig!.margin
            }
            button.frame = CGRect.init(x:itemX, y: 0, width: itemWidth, height: self.frame.size.height)
            itemX = itemX + itemWidth
        }
        itemX += itemConfig!.padding
        scroll.contentSize = CGSize.init(width: itemX, height: self.frame.size.height)
        
        let firstBtn = items![0]
        if itemConfig!.style == kPageTitleStyle.textBottomLine {
            bottomLine.frame = CGRect.init(x: itemConfig!.padding, y: self.frame.size.height - itemConfig!.textBottomLineHeight, width: firstBtn.frame.size.width, height: itemConfig!.textBottomLineHeight)
        }
    }
    
    @objc func click(sender:UIButton) {
        if lastItem!.isEqual(sender) {return}
        
        self.enlargeText(sender: sender)
        self.scrollToCenter(sender: sender)
        self.animationBottomLine(sender: sender)
        
        lastItem!.isSelected = false
        lastItem = sender
        lastItem!.isSelected = true
        
        //点击按钮调用闭包
        if clickBlock != nil {
            self.clickBlock!(sender.tag)
        }
    }
    
    //MARK: - StyleUI
    //放大文本内容
    private func enlargeText(sender:UIButton) {
        if itemConfig!.style == kPageTitleStyle.enlargeText {
            UIView.animate(withDuration: 0.25, animations: {
                self.lastItem!.transform = CGAffineTransform.identity
                sender.transform = __CGAffineTransformMake(CGFloat(1.2), 0, 0, CGFloat(1.2), 0, 0)
            })
        }
    }
    
    //移动动画
    private func animationBottomLine(sender:UIButton) {
        if itemConfig!.style == kPageTitleStyle.textBottomLine {
            UIView.animate(withDuration: 0.25) {
                let rect = self.bottomLine.frame
                self.bottomLine.frame = CGRect.init(x: sender.frame.origin.x, y: rect.origin.y, width: sender.frame.size.width, height:self.itemConfig!.textBottomLineHeight)
            }
        }
    }

    //始终保持被选中按钮居中显示
    let screenWidth = UIScreen.main.bounds.width
    private func scrollToCenter(sender:UIButton) {
        if scroll.contentSize.width <= screenWidth {return}
        let btnCenterX = sender.frame.size.width * 0.5 + sender.frame.origin.x
        let isLeft = btnCenterX > screenWidth * 0.5 ? true:false
        let isRight = scroll.contentSize.width - btnCenterX > screenWidth * 0.5 ? true:false
        if (isLeft && isRight) {
            scroll.setContentOffset(CGPoint.init(x: btnCenterX - screenWidth * 0.5, y: 0), animated: true)
        }else {
            if (!isLeft && isRight) {
                scroll.setContentOffset(CGPoint.zero, animated: true)
            }else if (isLeft && !isRight) {
                scroll.setContentOffset(CGPoint.init(x: scroll.contentSize.width - screenWidth, y: 0), animated: true)
            }
        }
    }
    
    func width(with str:String, height: CGFloat ,font:UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundingBox = str.boundingRect(with: constraintRect, options: option, attributes: attributes, context: nil)
        return boundingBox.width
    }
    
    //MARK: - lazy
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView.init()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    lazy var bottomLine: UIView = {
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: itemConfig!.textBottomLineHeight))
        return line
    }()
}

