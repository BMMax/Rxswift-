//
//  NSObject+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/14.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
extension NSObject {
    func setAssociated<T>(value: T, associatedKey: UnsafeRawPointer, policy: objc_AssociationPolicy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> Void {
        objc_setAssociatedObject(self, associatedKey, value, policy)
    }
    
    func getAssociated<T>(associatedKey: UnsafeRawPointer) -> T? {
        let value = objc_getAssociatedObject(self, associatedKey) as? T
        return value;
    }
}
