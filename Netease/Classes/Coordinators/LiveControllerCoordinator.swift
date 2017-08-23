//
//  LiveControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/8.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import RxSwift
final class LiveControllerCoordinator: BaseCoordinator<Void> {
    
    let presenter: NavigationViewController
    init(presenter: NavigationViewController) {
        self.presenter = presenter
        presenter.tabBarItem.image = #imageLiteral(resourceName: "tabbar_icon_live_normal_20x17_")
        presenter.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabbar_icon_live_highlight_20x17_")
        presenter.tabBarItem.title = "直播"

    }
    
    override func start() -> Observable<Void> {
        let newsViewController = LiveViewController()
        presenter.setViewControllers([newsViewController], animated: false)
        return Observable.never()
    }
    
}
