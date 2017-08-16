//
//  UIButtonExtension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/10.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit


extension UILayout where Base: UIButton {

    func addTarget(_ target: Any?, action: Selector) -> UILayout {
        base.addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    

    func addAction(_ target: Any?, action: @escaping (UIButton)->()) -> UILayout {
        
        base.actionClosure = action
        return addTarget(self, action: #selector(base.targetAction(_:)))
    }

}

extension UIButton {

    fileprivate struct AssociatedKeys {
    
        static var actionClosureKey = "actionClosureKey"
    }

    fileprivate var actionClosure: ((UIButton)->())? {
    
        get{
    
            guard let closure = objc_getAssociatedObject(self, &AssociatedKeys.actionClosureKey) as? (UIButton)->() else {return nil}
            return closure
        }
        
        set{
            
            setAssociated(value: newValue, associatedKey: &AssociatedKeys.actionClosureKey, policy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func targetAction(_ button: UIButton) {
        
        if let action = actionClosure {
            action(button)
        }
    }

}

