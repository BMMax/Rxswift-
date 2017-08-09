//
//  AppCoordinator.swift
//  RepoSearcher
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        
        self.window = window
    }

    override func start() -> Observable<Void> {
        let mainVC = MainTabBarViewController()
        let main = MainTabbarControllerCoordinator(presenter: mainVC)
        window.rootViewController = mainVC
        return coordinate(to: main)
        
    }
    
    
}
