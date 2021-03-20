//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Pavel Yurkov on 24.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol MainCoordinator {
    
    var tabBarController: UITabBarController { get set }
    var flowCoordinators: [FlowCoordinator] { get set }

    func start()
}
