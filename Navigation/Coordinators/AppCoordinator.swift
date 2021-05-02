//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Pavel Yurkov on 24.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class AppCoordinator: MainCoordinator {
    
    var tabBarController: UITabBarController
    var flowCoordinators = [FlowCoordinator]()
    
    let feedNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "house.fill")
        nc.title = "Feed"
        return nc
    }()
    
    let favoritesNavController: UINavigationController = {
        let nc = UINavigationController(rootViewController: ProfileViewController(user: User(), isInFavoritesMode: true))
        nc.tabBarItem.image = UIImage(systemName: "star.fill")
        nc.title = "Favorites"
        return nc
    }()
    
    let profileNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "person.fill")
        nc.title = "Profile"
        return nc
    }()
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        flowCoordinators = [
            FeedCoordinator(navigationController: feedNavController, mainCoordinator: self),
            ProfileCoordinator(navigationController: profileNavController, mainCoordinator: self)
        ]
        
        flowCoordinators.forEach() {
            $0.start()
        }

        let navControllers = [feedNavController, favoritesNavController, profileNavController]
        tabBarController.setViewControllers(navControllers, animated: true)
    }
    
}
