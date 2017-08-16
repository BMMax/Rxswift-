//
//  HomeViewController.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/7.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    var newsMenuView: NewsMenuView!
    lazy var listTops: [String] = {
        return ["头条", "独家", "NBA", "社会", "历史", "军事", "中国好表演", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubviews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController {


    func setupSubviews() {
        newsMenuView = NewsMenuView()
        newsMenuView.mb.added(into: self.view)
        newsMenuView.mb.added(into: self.view).then{ [weak self] in
            guard let `self` = self else {return}
            let menu = $0
            menu.visibleItemList = self.listTops
        }
            .makeLayout(NewsMenuViewLayout())
        
        
        newsMenuView.rx.didClickChannelEdit.subscribe(onNext: {
        
            print($0)
        }).addDisposableTo(disposeBag)
        
        newsMenuView.rx.didSelectItem.subscribe(onNext: {
        
            print($0.0)
            print($0.1)
        }).addDisposableTo(disposeBag)
    }
    
}
