//
//  FlowCoordinator.swift
//  Navigation
//
//  Created by Pavel Yurkov on 24.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FlowCoordinator {
    
    var mainCoordinator: AppCoordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
