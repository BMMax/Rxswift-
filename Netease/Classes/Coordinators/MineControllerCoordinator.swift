//
//  MineControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/8.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import RxSwift
final class MineControllerCoordinator: BaseCoordinator<Void> {
    
    let presenter: NavigationViewController
    init(presenter: NavigationViewController) {
        self.presenter = presenter
        presenter.tabBarItem.image = #imageLiteral(resourceName: "tabbar_personal_19x19_")
        presenter.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabbar_personal_highlighted_19x19_")
        presenter.tabBarItem.title = "我"

    }
    
    override func start() -> Observable<Void> {
        let newsViewController = MineViewController()
        presenter.setViewControllers([newsViewController], animated: false)
        return Observable.never()
    }
    
}
