//
//  UIView+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

public struct UILayout<Base> {
    
    public let base: Base
    public init(_ base: Base) {
        
        self.base = base
    }
}

public extension NSObjectProtocol {
    
    public var mb: UILayout<Self> {
        
        return UILayout(self)
    }
}

extension UILayout where Base: UIView {

    @discardableResult
    func added(into superView: UIView) -> UILayout {
        
        superView.addSubview(base)
        return self
    }
    
    @discardableResult
    func then(_ config: (Base) -> Void) -> UILayout {
        config(base)
        return self
    }
    
    @discardableResult
    func makeLayout(_ layout: Layoutable) -> UILayout {
        base.snp.makeConstraints(layout.layoutMaker())
        return self
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
