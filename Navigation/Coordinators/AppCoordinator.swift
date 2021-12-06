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
        nc.title = Localization.feed.localizedValue
        return nc
    }()
    
    let favoritesNavController: UINavigationController = {
        let nc = UINavigationController(rootViewController: ProfileViewController(user: User(), isInFavoritesMode: true))
        nc.tabBarItem.image = UIImage(systemName: "star.fill")
        nc.title = Localization.fav.localizedValue
        return nc
    }()
    
    let profileNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "person.fill")
        nc.title = Localization.profile.localizedValue
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
        tabBarController.tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
                
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        }
        
    }
    
}
