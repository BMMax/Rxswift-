//
//  AddView.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//  加号下拉菜单

import UIKit

class AddView: UIButton {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setImage(#imageLiteral(resourceName: "close_gray"), for: .normal)
        setImage(#imageLiteral(resourceName: "close_gray"), for: .highlighted)
        setImage(#imageLiteral(resourceName: "close_gray"), for: .selected)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imageSize: CGFloat = 12.0
        return CGRect(x: (contentRect.size.width - imageSize ) * 0.5,
                      y: (contentRect.size.height - imageSize) * 0.5 ,
                      width: imageSize,
                      height: imageSize)
    }
    
    func addAnimation(_ closure: @escaping ()-> ()) {
        
        let rotatioAngle = isSelected ? CGFloat(Double.pi / 4) : -CGFloat(Double.pi / 4)
        UIView.animate(withDuration: kAnimationTime) {
            self.transform = self.transform.rotated(by: rotatioAngle)
            //self.transform = CGAffineTransform(rotationAngle: rotatioAngle)
            closure()
        }
    }
    
}
