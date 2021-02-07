//
//  ContainerVIew.swift
//  Navigation
//
//  Created by Pavel Yurkov on 05.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    var onTap: (() -> Void)?
    
    private lazy var openPostButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Open Post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(openPostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var openAnotherPostButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Open Another Post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(openAnotherPostButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubviews(openPostButton, openAnotherPostButton)
        
        let constraints = [
            openPostButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            openPostButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            openPostButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            openPostButton.heightAnchor.constraint(equalToConstant: 30),
            
            openAnotherPostButton.topAnchor.constraint(equalTo: openPostButton.bottomAnchor, constant: 8),
            openAnotherPostButton.leadingAnchor.constraint(equalTo: openPostButton.leadingAnchor),
            openAnotherPostButton.trailingAnchor.constraint(equalTo: openPostButton.trailingAnchor),
            openAnotherPostButton.heightAnchor.constraint(equalToConstant: 30),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func openPostButtonTapped() {
        print("openPostButtonTapped in containerView")
        onTap?()
    }
    
    @objc private func openAnotherPostButtonTapped() {
        onTap?()
    }
    
}
