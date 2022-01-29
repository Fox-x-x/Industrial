//
//  LogInViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 11.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import Firebase

protocol LoginViewControllerDelegate {
    func loginOrRegisterUser(email: String, pass: String) throws -> User
    func signOut(user: User)
}

class LogInViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    weak var flowCoordinator: ProfileCoordinator?
    
    private var defaults = UserDefaults.standard
    
    // контейнер для всего контента на экране
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: ColorPalette.primaryColorLight, darkMode: ColorPalette.primaryColorDark)
        return view
    }()
    
    // scrollView для возможности скролла экрана во время наплыва контента :)
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        view.backgroundColor = UIColor.createColor(lightMode: ColorPalette.primaryColorLight, darkMode: ColorPalette.primaryColorDark)
        return scrollView
    }()
    
    // картинка логотипа
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        return logo
    }()
    
    // общий контейнер для texField'ов с логином и паролем и разделителем этих полей
    private lazy var emailAndPassCommonContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // UIView контайнер для TextField логина
    private lazy var loginContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // UIView контайнер для TextField пароля
    private lazy var passwordContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // textField для ввода логина
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor.createColor(lightMode: ColorPalette.secondaryColorLight, darkMode: ColorPalette.secondaryColorDark)
        textField.placeholder = Localization.emailOrPhone.localizedValue
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // textField для ввода пароля
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor.createColor(lightMode: ColorPalette.secondaryColorLight, darkMode: ColorPalette.secondaryColorDark)
        textField.isSecureTextEntry = true
        textField.placeholder = Localization.password.localizedValue
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // разедитель полей логина и пароля
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // кнопка Log in
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.loginButtonText.localizedValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.5), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // кнопка FaceID
    private var loginWithFaceIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("FaceID", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.5), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(loginWithFaceIDButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // скрываем NavigationBar
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        // настраиваем layout
        setupLayout()
        
        // keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("keyboardWillShow")
            scrollView.contentInset.bottom = keyboardSize.height + view.safeAreaInsets.bottom
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func textChanged(_ textField: UITextField) {
        loginButton.isEnabled = ![loginTextField, passwordTextField].contains { $0.text!.isEmpty }
    }
    
    @objc private func loginButtonPressed() {
        
        if let loginDelegate = delegate {
            if let email = loginTextField.text, let pass = passwordTextField.text {
                do {
                    let user = try loginDelegate.loginOrRegisterUser(email: email, pass: pass)
                    defaults.setValue(user.email, forKey: "recentUserEmail")
                    flowCoordinator?.goToProfile(user: user)
                } catch ApiError.wrongPassword {
                    handleApiError(error: .wrongPassword, vc: self)
                } catch {
                    handleApiError(error: .other, vc: self)
                }
            }
        }
    }
    
    @objc private func loginWithFaceIDButtonPressed() {
        let authService = LocalAuthorizationService()
        authService.authorizeIfPossible { [weak self] isSuccseeded in
            if let self = self {
                if isSuccseeded {
                    DispatchQueue.main.async {
                        self.flowCoordinator?.goToProfile(user: User())
                    }
                } else {
                    DispatchQueue.main.async {
                        handleApiError(error: .authError, vc: self)
                    }
                }
            }
        }
    }
    
    // MARK: Helpers
    // настраиваем layout
    private func setupLayout() {
        
        // добавляем прокручивалку на корневую view
        view.addSubviewWithAutolayout(scrollView)
        // на прокручивалку добавляем контейнер для всех элементов интерфейса на экране
        scrollView.addSubviewWithAutolayout(contentView)
        
        // logo
        contentView.addSubviews(logoImageView, emailAndPassCommonContainer)
        
        // login
        emailAndPassCommonContainer.addSubviewWithAutolayout(loginContainer)
        loginContainer.addSubviewWithAutolayout(loginTextField)
        
        // разделитель, password
        emailAndPassCommonContainer.addSubviews(separator, passwordContainer, passwordTextField)
        
        // кнопка log in, FaceID
        contentView.addSubviews(loginButton)
        contentView.addSubviews(loginWithFaceIDButton)
        
        let constraints = [
            
            // крутилка для контента
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // контейнер для контента на крутилке
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            // logo
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // общий контейнер, в котором будут лежать логин и пароль
            emailAndPassCommonContainer.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            emailAndPassCommonContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailAndPassCommonContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailAndPassCommonContainer.heightAnchor.constraint(equalToConstant: 100),
            
            // UIView контайнер для TextField логина
            loginContainer.topAnchor.constraint(equalTo: emailAndPassCommonContainer.topAnchor, constant: 12),
            loginContainer.leadingAnchor.constraint(equalTo: emailAndPassCommonContainer.leadingAnchor, constant: 16),
            loginContainer.trailingAnchor.constraint(equalTo: emailAndPassCommonContainer.trailingAnchor, constant: -16),
            loginContainer.heightAnchor.constraint(equalToConstant: 26),
            
            // textField для ввода логина
            loginTextField.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: loginContainer.centerYAnchor),
            loginTextField.widthAnchor.constraint(equalTo: loginContainer.widthAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 26),
            
            // разделитель
            separator.centerYAnchor.constraint(equalTo: emailAndPassCommonContainer.centerYAnchor),
            separator.widthAnchor.constraint(equalTo: emailAndPassCommonContainer.widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            // контайнер для TextField пароля
            passwordContainer.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            passwordContainer.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor),
            passwordContainer.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor),
            passwordContainer.heightAnchor.constraint(equalTo: loginContainer.heightAnchor),
            
            // textField для ввода пароля
            passwordTextField.centerXAnchor.constraint(equalTo: passwordContainer.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: passwordContainer.widthAnchor),
            passwordContainer.heightAnchor.constraint(equalToConstant: 26),
            
            // кнопка log in
            loginButton.topAnchor.constraint(equalTo: emailAndPassCommonContainer.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: emailAndPassCommonContainer.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailAndPassCommonContainer.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // кнопка FaceID
            loginWithFaceIDButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            loginWithFaceIDButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            loginWithFaceIDButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            loginWithFaceIDButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        // активируем все констрейнты
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension LogInViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}







