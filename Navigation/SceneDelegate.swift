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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Доступ к FeedViewController и PostPresenter возможен через SceneDelegate, как в первой задаче. Главный нюанс в том, что FeedViewController нужно инициализировать программно, и инжектить экземпляр презентера при инициализации контроллера или через свойство.
        let postPresenter = PostPresenter(navigationController: UINavigationController())
        let feedViewController = FeedViewController(output: postPresenter)

        let feedNavController: UINavigationController = {
            let nc = UINavigationController(rootViewController: feedViewController)
            nc.tabBarItem.image = UIImage(systemName: "house.fill")
            nc.title = "Feed"
            return nc
        }()

        let loginViewController = LogInViewController()

        let loginInspector = LoginInspector()
        loginViewController.delegate = loginInspector

        let loginNavController: UINavigationController = {
            let nc = UINavigationController(rootViewController: loginViewController)
            nc.tabBarItem.image = UIImage(systemName: "person.fill")
            nc.title = "Profile"
            return nc
        }()

        let tabBarViewController = UITabBarController()
        tabBarViewController.tabBar.backgroundColor = .white
        let tabBarViewControllers = [feedNavController, loginNavController]
        tabBarViewController.setViewControllers(tabBarViewControllers, animated: false)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
    }

}
