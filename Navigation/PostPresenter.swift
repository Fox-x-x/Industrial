//
//  PostPresenter.swift
//  Navigation
//
//  Created by Pavel Yurkov on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostPresenter: FeedViewOutput {
    
    unowned var flowCoordinator: FeedCoordinator
    
    init(_ flowCoordinator: FeedCoordinator) {
        self.flowCoordinator = flowCoordinator
    }
    
    func showPost() {
        print("show post")
        flowCoordinator.goToPost()
    }
    
    func goToGCDTest() {
        print("GCD")
        flowCoordinator.goToGCDTest()
    }
    
    func goToMusic() {
        flowCoordinator.goToMusic()
    }
    
    func goToYouTube() {
        flowCoordinator.goToYouTube()
    }
    
}
