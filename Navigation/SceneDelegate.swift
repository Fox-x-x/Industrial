//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    lazy var tabBarController = UITabBarController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        mainCoordinator = AppCoordinator(tabBarController: tabBarController)
        mainCoordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        window?.rootViewController = mainCoordinator?.tabBarController
        window?.makeKeyAndVisible()
        
    }
}
