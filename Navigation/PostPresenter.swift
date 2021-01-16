//
//  PostPresenter.swift
//  Navigation
//
//  Created by Pavel Yurkov on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// Класс PostPresenter, реализуя протокол FeedViewOutput, создает PostViewController, а далее использует протокольное свойство navigationController, чтобы презентовать PostViewController.
class PostPresenter: FeedViewOutput {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showPost() {
        print("show post")
        let postViewController = PostViewController()
        navigationController.pushViewController(postViewController, animated: true)
    }
    
}
