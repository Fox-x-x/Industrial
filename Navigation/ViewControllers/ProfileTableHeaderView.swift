//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// Если вы выполнили прошлое задание не в отдельном классе-наследнике UIView, то нужно перенести всю верстку в отдельный файл 'ProfileTableHederView.swift', в котором должен быть класс-наследник UIView с именем 'ProfileHeaderView'.
class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String?
    private let profileViewController = ProfileViewController()
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "cool_cat")
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 3
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Pavel Yurkov"
        label.sizeToFit()
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.sizeToFit()
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Type your text here"
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Show status", for: .normal)
        button.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .clear
        view.alpha = 0
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        
        return view
    }()
    
    private lazy var expandedAvatar = UIImageView(image: avatarImageView.image)
    
    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(systemName: "multiply"), for: button.state)
        button.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 0.9985017123).withAlphaComponent(0)
        button.isUserInteractionEnabled = true
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        button.addGestureRecognizer(tapGestureRecognizer)
        
        return button
    }()
    
    private var initialFrame: CGRect?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        
        backgroundColor = .systemGray6
        
        // добавляем сабвью
        addSubviews(fullNameLabel, statusLabel, statusTextField, setStatusButton, avatarImageView)
        
        // задаем констрейнты
        let constraints = [
            
            // аватар
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            // name Label
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // статус Label
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 32),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            
            // статус statusTextField
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // setStatusButton
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 44),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusTextField.text
    }
    
    @objc private func closeButtonTapped() {
        print("close tapped!")
        
        UIView.animate(withDuration: 0.3) { [self] in
            overlayView.alpha = 0
            closeButton.alpha = 0
            expandedAvatar.alpha = 0
        } completion: { [self] (_) in
            overlayView.removeFromSuperview()
            closeButton.removeFromSuperview()
            expandedAvatar.removeFromSuperview()
        }
        
    }
    
    @objc private func avatarTapped() {
        
        print("avatar tapped")
        
        var centerX = superview!.superview!.center.x - avatarImageView.frame.width / 2
        var centerY = superview!.superview!.center.y - avatarImageView.frame.height / 2
        
        // находим вьюконтроллер, на котором лежит текущая вью
        if let currentVC = self.findViewController() {
            if let tabBarHeight = currentVC.tabBarController?.tabBar.frame.height {
                centerX = overlayView.center.x - avatarImageView.frame.width / 2
                centerY = overlayView.center.y - avatarImageView.frame.height / 2 - tabBarHeight / 2
            }
        }
        
        // определяем высоту верхнего safeArea (нужно для того, чтобы потом расположить растянутую во весь экран аватарку по середине экрана)
        var topSafeAreaHeight: CGFloat = 0
        if let keyWindow = UIWindow.keyWindow {
            if let topSafeArea = keyWindow.rootViewController?.view.safeAreaInsets.top {
                topSafeAreaHeight = topSafeArea
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                addSubviewWithAutolayout(overlayView)
                overlayView.alpha = 1
                expandedAvatar.alpha = 1
                overlayView.addSubview(expandedAvatar)
                overlayView.addSubview(closeButton)
                
                expandedAvatar.frame = CGRect(x: centerX,
                                              y: centerY,
                                              width: avatarImageView.frame.width,
                                              height: avatarImageView.frame.height
                )
                
                closeButton.alpha = 1
                
                closeButton.frame = .init(
                    x: overlayView.bounds.maxX - 32,
                    y: overlayView.bounds.minY + 54,
                    width: closeButton.frame.width,
                    height: closeButton.frame.height
                )
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                expandedAvatar.frame = CGRect(x: overlayView.frame.minX,
                                              y: (overlayView.frame.height - overlayView.frame.width) / 2 - topSafeAreaHeight,
                                             width: overlayView.frame.width,
                                             height: overlayView.frame.width
                )
            }
            
        } completion: { finished in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, options: []) { [self] in
                closeButton.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1).withAlphaComponent(0.6)
            }
            print(finished)
        }
        
    }
    
}
