//
//  UIView+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func makeLayout<T: UIView>(_ layout: Layoutable) -> T {
        snp.makeConstraints(layout.layoutMaker())
        return self as! T
    }
}
extension UIView {
    
    @discardableResult
    func added<T: UIView>(into superView: UIView) -> T {
        
        superView.addSubview(self)
        return self as! T
    }
    
    @discardableResult
    func then<T: UIView>(_ config: (T) -> Void) -> T {
        config(self as! T)
        return self as! T
    }
    
}


// MARK: - 圆角
extension UIView {

    func drawRounded(byRoundingCorners: UIRectCorner, cornerRadii: CGFloat) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: byRoundingCorners,
                                    cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer =  CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        
        
    }

}
