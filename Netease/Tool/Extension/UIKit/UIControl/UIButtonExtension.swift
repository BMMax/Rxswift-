//
//  UIButtonExtension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/10.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIButton {

    typealias ActionClosure = ((UIButton)->())?
    fileprivate struct AssociatedKeys {
    
        static var actionClosure: ActionClosure
    
    }
    func addTarget(_ target: Any?, action: Selector) -> UIView {
        
        self.addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    fileprivate var actionClosure: ActionClosure {
    
        get{
    
            guard let closure = objc_getAssociatedObject(self, &AssociatedKeys.actionClosure) as? ActionClosure else {return nil}
            return closure
        }
        
        set{
            
            objc_setAssociatedObject(self, &AssociatedKeys.actionClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addAction(_ target: Any?, action: ActionClosure) -> UIView {
        
        actionClosure = action
        self.addTarget(target, action: #selector(targetAction(_:)), for: .touchUpInside)
        return self
    }
    
    func targetAction(_ button: UIButton) {
        
        if let action = actionClosure {
            action(button)
        }
    }

}

