//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Pavel Yurkov on 25.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileCoordinator: FlowCoordinator {
    
    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let vc = LogInViewController()
        vc.flowCoordinator = self
        vc.title = "Profile"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfile() {
        let vc = ProfileViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPhotos() {
        let model = PhotosModel.init()
        let viewModel = PhotosViewModel.init(model: model, photos: [])
        let view = PhotosView.init(vm: viewModel)
        view.flowCoordinator = self
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(view, animated: true)
    }
}
