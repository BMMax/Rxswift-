//
//  HomeControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/7.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import RxSwift

final class HomeControllerCoordinator: BaseCoordinator<Void> {

    let presenter: NavigationViewController
    init(presenter: NavigationViewController) {
        self.presenter = presenter
    }

    override func start() -> Observable<Void> {
        let homeViewController = HomeViewController()
        presenter.setViewControllers([homeViewController], animated: false)
        return Observable.never()
    }
}
