//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
    private lazy var addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfoButtonTapped))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        self.navigationItem.setRightBarButton(addBarButton, animated: true)
    }
    
    @objc private func showInfoButtonTapped() {
        flowCoordinator?.goToInfo()
    }
}
