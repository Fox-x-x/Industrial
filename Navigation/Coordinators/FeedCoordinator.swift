//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Pavel Yurkov on 24.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FeedCoordinator: FlowCoordinator {
    
    var navigationController: UINavigationController
    lazy var postPresenter = PostPresenter(self)
    weak var mainCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let vc = FeedViewController(output: postPresenter)
        vc.title = "Feed"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPost() {
        let vc = PostViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToInfo() {
        let vc = InfoViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToGCDTest() {
        let vc = GCDTestViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMusic() {
        let vc = MusicViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToYouTube() {
        let vc = YouTubeViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
