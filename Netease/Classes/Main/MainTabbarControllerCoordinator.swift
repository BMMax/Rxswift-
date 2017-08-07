//
//  MainTabbarControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/7.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import RxSwift

final class MainTabbarControllerCoordinator: BaseCoordinator<Void> {
//=======================================================
// MARK: 属性
//=======================================================
    private let tabBarController: MainTabBarViewController
    private let childCoordinators: [Any]
    private let homeCoordinator = HomeControllerCoordinator(presenter: NavigationViewController())
    private let newsCoordinator = NewsControllerCoordinator(presenter: NavigationViewController())
    
//=======================================================
// MARK: 构造方法
//=======================================================
    init(presenter: MainTabBarViewController) {
        tabBarController = presenter
        childCoordinators = [homeCoordinator,newsCoordinator]
    }
    
   
    override func start() -> Observable<CoordinationResult> {
        
        for coordinators in childCoordinators {
            
            switch coordinators {
            case let home as HomeControllerCoordinator:
                tabBarController.addChildViewController(home.presenter)
                
            case let news as NewsControllerCoordinator:
                tabBarController.addChildViewController(news.presenter)
            default:
                break
            }
        }
        return Observable.never()
    }
}
