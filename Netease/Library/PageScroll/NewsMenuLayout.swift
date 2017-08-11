//
//  NewsMenuLayout.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/10.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import SnapKit


//=======================================================
// MARK: HeaderView
//=======================================================

///0. headerView
struct NewsMenuViewLayout: Layoutable {

    func layoutMaker() -> (ConstraintMaker) -> Void {
        return { make in
        
            make.left.right.equalToSuperview()
            make.top.equalTo(64)
            make.height.equalTo(40)
        }
    }

}

let kAddButtonWidth = 40
let kAnimationTime = 0.25
/// 1.滚动条里面按钮
struct ItemLayout: Layoutable {
    
    func layoutMaker() ->(ConstraintMaker) -> Void {
        
        return { make in
        
            make.centerY.equalTo(self.superView)
            
            if self.superView.subviews.count == 1 {
                make.left.equalTo(self.superView.snp.left).offset(15)
            } else if self.superView.subviews.count == self.itemsCount {
                make.left.equalTo((self.superView.subviews[self.superView.subviews.count - 2].snp.right)).offset(15)
                make.right.equalTo(self.superView).offset(-15)
            } else {
                make.left.equalTo((self.superView.subviews[self.superView.subviews.count - 2].snp.right)).offset(15)
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


/// 2. 滚动条布局
struct TitleScrollViewLayout: Layoutable {
    
    func layoutMaker() ->(ConstraintMaker) -> Void {
    
    
        return { make in
        
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(-kAddButtonWidth)
        }
    }
}
/// 3. addView
struct AddButtonLayout: Layoutable {

    func layoutMaker() -> (ConstraintMaker) -> Void {
        return { make in
        
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(kAddButtonWidth)
        }
    }
}

/// 4.0 ChannelEditView -> 切换栏目
struct ChannelEditLabelLayout: Layoutable {
    
    func layoutMaker() ->(ConstraintMaker) -> Void {
    
        return { make in
        
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
}

///5.0 ChannelEditSort -> 排序删除
struct ChannelEditSortButtonLayout: Layoutable {

    func layoutMaker() -> (ConstraintMaker) -> Void {
        
        return { make in
        
            make.centerY.equalToSuperview()
            make.right.equalTo(-kAddButtonWidth-10)
        }
    }



}


