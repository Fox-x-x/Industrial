//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var feedViewController: UINavigationController = {
        let nc = UINavigationController(rootViewController: FeedViewController())
        nc.title = "Feed"
        if #available(iOS 13.0, *) {
            nc.tabBarItem.image = UIImage(systemName: "house.fill")
        } else {
            nc.tabBarItem.image = UIImage(named: "house")
        }
        return nc
    }()
    
    private lazy var profileViewController: UINavigationController = {
        let nc = UINavigationController(rootViewController: ProfileViewController())
        nc.title = "Profile"
        if #available(iOS 13.0, *) {
            nc.tabBarItem.image = UIImage(systemName: "person.fill")
        } else {
            nc.tabBarItem.image = UIImage(named: "person")
        }
        return nc
    }()
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarViewController = UITabBarController()
        let tabBarViewControllers = [feedViewController, profileViewController]
        tabBarViewController.setViewControllers(tabBarViewControllers, animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(type(of: self), #function)
        
        // Запишите это время в комментариях, в методе applicationDidEnterBackground
        // таймер показал 29.9 секунд
    }
    
    


}

