//
//  ChannelEditBar.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/11.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
class ChannelEditBar: UIView {
    
    let kTransferTap: String = "kTransferTap"
    let textFont = UIFont.systemFont(ofSize: 14)
    private var sortBtn: UIButton!
    private var channelLabel: UILabel!
    
    //=======================================================
    // MARK: init
    //=======================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        channelLabel = UILabel()
        channelLabel.added(into: self).then{
            let label = $0 as! UILabel
            label.text = "切换栏目"
            label.font = textFont
            label.textColor = UIColor.black
        }
        .makeLayout(ChannelEditLabelLayout())
        
        sortBtn = UIButton(type: .custom)
        sortBtn.addAction(self) {[weak self] in
            guard let `self` = self else {return}
            if $0.isSelected {
                $0.setTitle("完成", for: .normal)
            } else {
                $0.setTitle("排序删除", for: .normal)
            }
                $0.isSelected = !$0.isSelected
                $0.router(with: self.kTransferTap, userInfo: nil)
            }
            .added(into: self)
            .then {
                let btn = $0 as! UIButton
                btn.setTitleColor(kMainRedColor, for: .normal)
                btn.setTitle("排序删除", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                btn.layer.borderWidth = 1
                btn.layer.borderColor = kMainRedColor.cgColor
                btn.drawRounded(byRoundingCorners: .allCorners, cornerRadii: 5)
            }
            .makeLayout(ChannelEditSortButtonLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
