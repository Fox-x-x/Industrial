//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewOutput {
    var flowCoordinator: FeedCoordinator { get set }
    func showPost()
}

final class FeedViewController: UIViewController {

    var output: FeedViewOutput
    weak var flowCoordinator: FeedCoordinator?
    var timerCounter = 10
    private lazy var timer = Timer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    
    private lazy var containerView: ContainerView = {
        let view = ContainerView()
        view.onTap = {
            print("onTap!")
            self.output.showPost()
        }
        return view
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    init(output: FeedViewOutput) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
        
        startTimer()
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
    
    func startTimer() {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc func fireTimer() {
        print("Осталось: \(timerCounter)")
        counterLabel.text = "Осталось: \(timerCounter)"
        if timerCounter > 0 {
            timerCounter -= 1
        } else {
            print("БУМ!")
            counterLabel.text = "БУМ! :)"
            timer.invalidate()
        }
    }
    
    private func setupViews() {
        
        view.addSubviews(containerView, counterLabel)
        
        let constraints = [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            
            counterLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    @objc func openPostButtonTapped() {
        print("openPostButtonTapped in FeedViewController")
        flowCoordinator?.goToPost()
    }
    
}
