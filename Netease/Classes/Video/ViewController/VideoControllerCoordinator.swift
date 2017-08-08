//
//  VideoControllerCoordinator.swift
//  Netease
//
//  Created by B2B-IOS on 2017/8/8.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import RxSwift
final class VideoControllerCoordinator: BaseCoordinator<Void> {
    
    let presenter: NavigationViewController
    init(presenter: NavigationViewController) {
        self.presenter = presenter
        presenter.tabBarItem.image = #imageLiteral(resourceName: "tabbar_video_19x19_")
        presenter.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabbar_video_highlighted_19x19_")
        presenter.tabBarItem.title = "视频"

    }
    
    override func start() -> Observable<Void> {
        let newsViewController = VideoViewController()
        presenter.setViewControllers([newsViewController], animated: false)
        return Observable.never()
    }
    
}
