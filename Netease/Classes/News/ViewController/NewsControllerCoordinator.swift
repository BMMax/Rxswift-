//
//  NewsControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/7.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import RxSwift

final class NewsControllerCoordinator: BaseCoordinator<Void> {

    let presenter: NavigationViewController
    init(presenter: NavigationViewController) {
        self.presenter = presenter
        presenter.tabBarItem.image = #imageLiteral(resourceName: "tabbar_icon_importantNews_normal_15x20_")
        presenter.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabbar_icon_importantNews_highlight_15x20_")
        presenter.tabBarItem.title = "要闻"

    }
    
    override func start() -> Observable<Void> {
        let newsViewController = NewsViewController()
        presenter.setViewControllers([newsViewController], animated: false)
        return Observable.never()
    }

}
