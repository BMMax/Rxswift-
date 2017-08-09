//
//  UIView+Extension.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/9.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIView {

    func makeLayout(_ layout: Layoutable) {
        snp.makeConstraints(layout.layoutMaker())
    }

}
