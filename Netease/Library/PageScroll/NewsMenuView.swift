//
//  HeaderView.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

//=======================================================
// MARK: 滚动条
//=======================================================
protocol NewsMenuViewDelegate: NSObjectProtocol {
    func newsMenuView(_ menuView: NewsMenuView, selectedIndex: Int)
    func didClickChannelEdit()
}
class NewsMenuView: UIView {
    
    /// 属性
    weak var delegate: NewsMenuViewDelegate?
    fileprivate var titleScrollView: TitleScrollView!
    fileprivate var addItemView: AddView!
    fileprivate var channelEditBar: ChannelEditBar?
    var visibleItemList: [String]? {
        didSet {
            titleScrollView.visibleItemList = visibleItemList
        }
    }
    
    /// init 
    override init(frame: CGRect) {
        super.init(frame: frame)

        /// +
        addItemView = AddView()
        addItemView.addAction(self){ [weak self] btn in
                guard let `self` = self else {return}
                if self.channelEditBar == nil {
                    self.channelEditBar = ChannelEditBar()
                    self.channelEditBar?.added(into: self).makeLayout(TitleScrollViewLayout())
                    self.channelEditBar?.isHidden = true 
                }
                self.channelEditBar?.isHidden = !(self.channelEditBar?.isHidden ?? false)
                self.addItemView.isSelected = !self.addItemView.isSelected
                self.addItemView.addAnimation{
                    self.delegate?.didClickChannelEdit()
                }
            }
            .added(into: self)
            .makeLayout(AddButtonLayout())
        
        
        /// scrollView
        titleScrollView = TitleScrollView()
        titleScrollView.added(into: self)
            .then{($0 as! TitleScrollView).titleDelegate = self}
            .makeLayout(TitleScrollViewLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NewsMenuView: TitleScrollViewDelegate {

    fileprivate func titleScrollView(scrollView: TitleScrollView, selectedButtonIndex: Int) {
    
        delegate?.newsMenuView(self,selectedIndex: selectedButtonIndex)
    }
}

//=======================================================
// MARK: TitleScrollView -> 滚动菜单
//=======================================================
private protocol TitleScrollViewDelegate: NSObjectProtocol {
    func titleScrollView(scrollView: TitleScrollView, selectedButtonIndex: Int)
}

private class TitleScrollView: UIScrollView {
    /// 属性
    weak var titleDelegate: TitleScrollViewDelegate?
    var currentIndex: Int = 0
    var visibleItemList: [String]? {
    
        didSet{
            guard let items = visibleItemList, items.count > 0 else {return}
            self.setupVisibleItemList(with: items)
        }
    }
    /// init
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    /// 设置button
    func setupVisibleItemList(with items: [String]) {
        
        let buttonLayout = ItemLayout(itemsCount: items.count, superView: self )
        for (index, item) in items.enumerated() {
            let btn = UIButton(type: .custom)
            btn.addAction(self){[weak self] in
                    guard let `self` = self else {return}
                    self.selectButton(withFrom: self.currentIndex, to: $0.tag)
                    self.titleDelegate?.titleScrollView(scrollView: self,selectedButtonIndex: $0.tag)
                }
                .added(into: self)
                .then{
                    let btn = $0 as! UIButton
                    btn.setTitleColor(.black, for: .normal)
                    btn.setTitle(item, for: .normal)
                    btn.tag = index
                }
                .makeLayout(buttonLayout)
           
        }
    }
    
    /// 选中某个标题
    func selectButton(withFrom currentIndex: Int, to toIndex: Int) {
    
        if currentIndex == 0 && toIndex == 0 {
        
            let currentBtn = subviews[currentIndex] as! UIButton
            currentBtn.setTitleColor(kMainRedColor, for: .normal)
            currentBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        if currentIndex == toIndex {return}
        let currentButton = subviews[currentIndex] as! UIButton
        let desButton = subviews[toIndex] as! UIButton
        currentButton.setTitleColor(.black, for: .normal)
        desButton.setTitleColor(kMainRedColor, for: .normal)
        currentButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        desButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        let screenMidX = kScreenwidth / 2
        let desButtonMidX = desButton.frame.minX + desButton.frame.width / 2
        let buttonScrollViewDiff = self.contentSize.width - desButtonMidX
        if buttonScrollViewDiff <= screenMidX { //如果最右边与midX的差值小于屏幕宽度的一半，滑动到最右边
            let scrollOffset = CGPoint(x: self.contentSize.width - kScreenwidth, y: 0)
            self.setContentOffset(scrollOffset, animated: true)
        } else if desButtonMidX > screenMidX {  //正常滑动
            let scrollOffset = CGPoint(x: desButtonMidX - screenMidX, y: 0)
            self.setContentOffset(scrollOffset, animated: true)
        } else if desButtonMidX <= screenMidX { //如果左边的button的midX小于屏幕宽度的一般，滑动到最左边
            let scrollOffset = CGPoint(x: 0, y: 0)
            self.setContentOffset(scrollOffset, animated: true)
        }
        
        self.currentIndex = toIndex
    }
}

