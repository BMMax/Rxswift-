//
//  Common.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/8.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import SnapKit

//=======================================================
// MARK: Property
//=======================================================
let kMainRedColor = UIColor(r: 206, g: 65, b: 58)

//=======================================================
// MARK: Protocol
//=======================================================
/// 布局
protocol Layoutable {
    func layoutMaker() ->(ConstraintMaker) -> Void
}

//=======================================================
// MARK: Function
//=======================================================

/// 自定义打印
func debugPrint<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        let className = (fileName as NSString).deletingPathExtension
        
        print("\(fileName):(line:\(lineNum))-[\(className) \(funcName)]-\(message)")
        
    #endif
    
}
