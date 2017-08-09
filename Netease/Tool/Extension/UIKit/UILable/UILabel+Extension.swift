//
//  UILabel+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

enum LabelStyle {
    case title
    case subTitle
    
}
extension UILabel {

    static func with(style initalStyle: LabelStyle) -> UILabel {
    
        switch initalStyle {
        case .title:
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.black
            return label
            
        default:
            return UILabel()
        }
    }
}

extension UILabel {

    @discardableResult
    func added(into superView: UIView) -> UILabel {
        
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func then(config: (UILabel) -> Void) -> UILabel {
        config(self)
        return self
    }
    
}
