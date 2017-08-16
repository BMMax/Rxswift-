//
//  HeaderView.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//=======================================================
// MARK: 滚动条
//=======================================================
@objc protocol NewsMenuViewDelegate: class {
    @objc optional func newsMenuView(_ menuView: NewsMenuView, selectedIndex: Int)
    @objc optional func didClickChannelEdit()
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
        addItemView.mb.addAction(self){ [weak self] btn in
                guard let `self` = self else {return}
                if self.channelEditBar == nil {
                    self.channelEditBar = ChannelEditBar()
                    self.channelEditBar?.mb.added(into: self).makeLayout(TitleScrollViewLayout())
                    self.channelEditBar?.isHidden = true 
                }
                self.channelEditBar?.isHidden = !(self.channelEditBar?.isHidden ?? false)
                self.addItemView.isSelected = !self.addItemView.isSelected
                self.addItemView.addAnimation{
                    if let click = self.delegate?.didClickChannelEdit {
                        click()
                    }
                }
            }
            .added(into: self)
            .makeLayout(AddButtonLayout())
        
        
        /// scrollView
        titleScrollView = TitleScrollView()
        titleScrollView.mb.added(into: self)
            .then{$0.titleDelegate = self}
            .makeLayout(TitleScrollViewLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NewsMenuView: TitleScrollViewDelegate {

    fileprivate func titleScrollView(scrollView: TitleScrollView, selectedButtonIndex: Int) {
    
        if let selectBtn = delegate?.newsMenuView {
        
            selectBtn(self, selectedButtonIndex)
        }
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
            btn.mb.addAction(self){[weak self] in
                    guard let `self` = self else {return}
                    self.selectButton(withFrom: self.currentIndex, to: $0.tag)
                    self.titleDelegate?.titleScrollView(scrollView: self,selectedButtonIndex: $0.tag)
                }
                .added(into: self)
                .then{
                    let btn = $0
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

//=======================================================
// MARK: 滚动条 Rx-> Delegate
//=======================================================
// workaround for Swift compiler bug, cheers compiler team :)
func castOptionalOrFatalError<T>(value: AnyObject?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value: value)
    return v
}
func castOrThrow<T>(resultType: T.Type, _ object: AnyObject) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}

func castOptionalOrThrow<T>(resultType: T.Type, _ object: AnyObject) throws -> T? {
    if NSNull().isEqual(object) {
        return nil
    }
    
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}

func castOrFatalError<T>(value: AnyObject!, message: String) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        rxFatalError(lastMessage: message)
    }
    
    return result
}

func castOrFatalError<T>(value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        rxFatalError(lastMessage: "Failure converting from \(value) to \(T.self)")
    }
    
    return result
}

func rxFatalError(lastMessage: String) -> Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage)
}

extension Reactive where Base: NewsMenuView {

     class RxNewsMenuViewDelegateProxy: DelegateProxy, DelegateProxyType, NewsMenuViewDelegate {
     
        //We need a way to read the current delegate
        class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
            let mapView: NewsMenuView = object as! NewsMenuView
            return mapView.delegate
        }
        //We need a way to set the current delegate
        class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
            let mapView: NewsMenuView = object as! NewsMenuView
            mapView.delegate = delegate as? NewsMenuViewDelegate
        }
    
        public override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
            let custom = (object as! NewsMenuView)
            return castOrFatalError(value: custom.rx.creatDelegateProxy)
        }
    
    }
    
}



extension Reactive where Base: NewsMenuView {

    func creatDelegateProxy() -> RxNewsMenuViewDelegateProxy {
    
        return RxNewsMenuViewDelegateProxy(parentObject: base)
    }
}




