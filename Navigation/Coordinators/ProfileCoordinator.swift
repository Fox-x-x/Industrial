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
    
    private var defaults = UserDefaults.standard
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let loginInspector = LoginInspector()
        
        if let userEmail = defaults.object(forKey: "recentUserEmail") as? String {
            if let user = loginInspector.findUser(email: userEmail), user.wasLogedIn == true {
                goToProfile(user: user)
            } else {
                goToLogin()
            }
        } else {
            goToLogin()
        }
    }
    
    func goToProfile(user: User) {
        let vc = ProfileViewController(user: user, isInFavoritesMode: false)
        let loginInspector = LoginInspector()
        vc.delegate = loginInspector
        vc.flowCoordinator = self
        vc.title = "Profile"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToLogin() {
        let loginInspector = LoginInspector()
        let vc = LogInViewController()
        vc.title = "Profile"
        vc.delegate = loginInspector
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
