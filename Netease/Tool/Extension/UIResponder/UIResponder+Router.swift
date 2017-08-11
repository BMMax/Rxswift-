//
//  UIResponder+Router.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/11.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIResponder {

    func router(with eventName: String, userInfo: Dictionary<String, Any>?) {
        
        if let next = self.next {
            next.router(with: eventName, userInfo: userInfo)
        }
    }
}
