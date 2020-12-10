//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        button.tintColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        title = "Post"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func addButtonTapped() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true, completion: nil)
    }
}
