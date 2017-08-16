//
//  NewsMenuView+Rx.swift
//  Netease
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//=======================================================
// MARK: 滚动条 Rx-> Delegate
//=======================================================
// workaround for Swift compiler bug, cheers compiler team :)

func rxFatalError(_ lastMessage: String) -> Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage)
}

func castOptionalOrFatalError<T>(_ value: AnyObject?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value)
    return v
}
func castOrThrow<T>(resultType: T.Type, _ object: Any) throws -> T {
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
        rxFatalError(message)
    }
    
    return result
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        rxFatalError("Failure converting from \(value) to \(T.self)")
    }
    
    return result
}




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
        return castOrFatalError(custom.rx.creatDelegateProxy)
    }
    //对于appDelegate这里必须强引用，不然appDelegate就被释放了。
    override func setForwardToDelegate(_ delegate: AnyObject?, retainDelegate: Bool) {
        super.setForwardToDelegate(delegate, retainDelegate: false)
    }
    
}

extension Reactive where Base: NewsMenuView {
    
    var delegate: DelegateProxy {
        
        return RxNewsMenuViewDelegateProxy.proxyForObject(base)
    }
    
    fileprivate var creatDelegateProxy: RxNewsMenuViewDelegateProxy {
        
        return RxNewsMenuViewDelegateProxy(parentObject: base)
    }
    
 
    
    var didClickChannelEdit: Observable<(NewsMenuView)> {
        
        return delegate.sentMessage(#selector(NewsMenuViewDelegate.didClickChannelEdit)).map({
            let menu = try castOrThrow(resultType: NewsMenuView.self, $0[0])
            return (menu)
        })
    }
    
    var didSelectItem: Observable<(NewsMenuView, Int)> {
        
        return delegate.sentMessage(#selector(NewsMenuViewDelegate.newsMenuView(_:selectedIndex:))).map({
            
            let menu = try castOrThrow(resultType: NewsMenuView.self, $0[0])
            let int = try castOrThrow(resultType: Int.self, $0[1])
            return (menu, int)
        })
    }
}





