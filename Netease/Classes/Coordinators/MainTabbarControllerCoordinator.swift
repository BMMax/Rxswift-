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
    private let liveCoordinator = LiveControllerCoordinator(presenter: NavigationViewController())
    private let videoCoordinator = VideoControllerCoordinator(presenter: NavigationViewController())
    private let mineCoordinator = MineControllerCoordinator(presenter: NavigationViewController())
    
//=======================================================
// MARK: 构造方法
//=======================================================
    init(presenter: MainTabBarViewController) {
        tabBarController = presenter
        childCoordinators = [homeCoordinator,
                             newsCoordinator,
                             liveCoordinator,
                             videoCoordinator,
                             mineCoordinator]
        // 字体颜色
        var attrs = [String: NSObject]()
        attrs[NSForegroundColorAttributeName] = kMainRedColor
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for:.selected)
    }
    
    override func start() -> Observable<Void> {
        
        for coordinators in childCoordinators {
            
            switch coordinators {
            case let home as HomeControllerCoordinator:
                tabBarController.addChildViewController(home.presenter)
            case let news as NewsControllerCoordinator:
                tabBarController.addChildViewController(news.presenter)
            case let live as LiveControllerCoordinator:
                tabBarController.addChildViewController(live.presenter)
            case let video as VideoControllerCoordinator:
                tabBarController.addChildViewController(video.presenter)
            case let mine as MineControllerCoordinator:
                tabBarController.addChildViewController(mine.presenter)
            default:
                break
            }
        }
        return coordinate(to: homeCoordinator)
            .concat(coordinate(to: newsCoordinator))
            .concat(coordinate(to: liveCoordinator))
            .concat(coordinate(to: videoCoordinator))
            .concat(coordinate(to: mineCoordinator))
    }
}
