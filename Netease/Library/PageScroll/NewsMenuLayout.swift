//
//  NewsMenuLayout.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/10.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import SnapKit

struct ItemLayout: Layoutable {
    
    func layoutMaker() ->(ConstraintMaker) -> Void {
        
        return { make in
        
            make.centerY.equalTo(self.superView)
            if self.superView.subviews.count == 1 {
            
                make.left.equalTo(self.superView.snp.left).offset(15)
            } else if self.superView.subviews.count == self.itemsCount {
                
                make.left.equalTo(self.superView.subviews[self.superView.subviews.count - 2].snp.right).offset(15)
                make.right.equalTo(self.superView).offset(-15)
            } else {
            
                make.left.equalTo(self.superView.subviews[self.superView.subviews.count - 2].snp.right).offset(15)
            }
        }
    }
    var superView: UIView
    var itemsCount: Int
    init(itemsCount: Int, superView: UIView) {
        
        self.itemsCount = itemsCount
        self.superView = superView
    }
}
