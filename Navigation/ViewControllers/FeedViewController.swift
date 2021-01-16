//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// У вашего протокола FeedViewOutput будет 1 метод showPost() (название на ваш вкус), в котором нужно инициализировать PostViewController. А также 1 свойство var navigationController: UINavigationController? { get set }
protocol FeedViewOutput {
    // протокол лучше здесь писать или правилом хорошего тона будет вынести в отдельный файл?
    func showPost()
    var navigationController: UINavigationController { get set }
}

final class FeedViewController: UIViewController {
    
    // Создаем свойство output у контроллера FeedViewController - оно будет протокольного типа FeedViewOutput.
    var output: FeedViewOutput?
    
    // Определить замыкание onTap надо в контроллере FeedViewController, когда будете определять/конфигурировать ContainerView. В замыкании будет только вызов единственного метода свойства output (тип FeedViewOutput).
    private lazy var containerView: ContainerView = {
        let view = ContainerView()
        view.onTap = {
            print("onTap!")
            self.output?.showPost()
        }
        return view
    }()
    
    // Инъекция зависимости FeedViewController от FeedViewOutput происходит через инициализатор.
    init(output: FeedViewOutput, coder aDecoder: NSCoder) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        view.backgroundColor = .systemGreen
        
        setupViews()
        
        // Чтобы PostPresenter мог использовать свойство navigationController от FeedViewController, нужно передать navigationController от FeedViewController -> PostPresenter. Например, в viewDidLoad() контроллера.
        output?.navigationController = self.navigationController ?? UINavigationController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    private func setupViews() {
        
        view.addSubviewWithAutolayout(containerView)
        
        let constraints = [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    
}
