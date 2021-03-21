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
    let appConfigurations = [AppConfiguration.people.rawValue, AppConfiguration.starships.rawValue, AppConfiguration.planets.rawValue]
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let appConfiguration = appConfigurations[Int.random(in: 0..<appConfigurations.count)]
        
        if let url = URL(string: appConfiguration) {
            NetworkManager.dataTask(url: url) { (string) in
                if let result = string {
                    print("\nNetworkManager dataTask result:\n\(result) ")
                }
            }
        } else {
            print("=============================")
            print("incorrect URL! Unable to run NetworkManager.dataTask")
            print("=============================\n")
        }
        
        mainCoordinator = AppCoordinator(tabBarController: tabBarController)
        mainCoordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        window?.rootViewController = mainCoordinator?.tabBarController
        window?.makeKeyAndVisible()
        
    }
}
