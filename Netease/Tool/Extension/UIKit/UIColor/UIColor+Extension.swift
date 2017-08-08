//
//  UIColor+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/8.
//  Copyright © 2017年 mobin. All rights reserved.
//
#if !os(macOS)

import UIKit

public extension UIColor {

    //=======================================================
    // MARK: init
    //=======================================================
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        if string.characters.count == 3 {
        
            var str = ""
            string.characters.forEach({
                let double = String($0) + String($0)
                str.append(double)
            })
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else {
            return nil
        }
        
        self.init(rgbHex: Int(hexValue))
    }
    
    public convenience init(rgbHex: Int, alpha: CGFloat = 1) {
        let red = (rgbHex >> 16) & 0xFF
        let green = (rgbHex >> 8) & 0xFF
        let blue = (rgbHex) & 0xFF
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    //=======================================================
    // MARK: Property
    //=======================================================
    
    /// 随机色
    static var randomColor: UIColor{
        
        let r = CGFloat(arc4random_uniform(UInt32(255))) / CGFloat(255)
        let g = CGFloat(arc4random_uniform(UInt32(255))) / CGFloat(255)
        let b = CGFloat(arc4random_uniform(UInt32(255))) / CGFloat(255)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
    }

}

#endif
