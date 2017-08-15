//
//  UIButtonExtension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/10.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIButton {

    fileprivate struct AssociatedKeys {
    
        static var actionClosureKey = "actionClosureKey"
    }
    func addTarget(_ target: Any?, action: Selector) -> UIView {
        
        self.addTarget(target, action: action, for: .touchUpInside)
        return self
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
    
     func addAction(_ target: Any?, action: @escaping (UIButton)->()) -> UIView {
        
        actionClosure = action
        return addTarget(self, action: #selector(targetAction(_:)))
    }
    
    func targetAction(_ button: UIButton) {
        
        if let action = actionClosure {
            action(button)
        }
    }

}

