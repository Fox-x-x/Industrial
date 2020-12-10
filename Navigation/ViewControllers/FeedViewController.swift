//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: background timer, properties and methods
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }
      assert(backgroundTask != .invalid)
    }
      
    func endBackgroundTask() {
      print("Background task ended.")
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
    
    // MARK: UI elements
    private lazy var openPostButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("open post", for: .normal)
        button.addTarget(self, action: #selector(openPostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var startBackgroundTaskButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("start timer", for: .normal)
        button.addTarget(self, action: #selector(startBackgroundTaskButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        view.backgroundColor = .systemGreen
        title = "Feed"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        setupLayout()
        
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: viewController Life Cicle (other)
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
    
    private func setupLayout() {
        view.addSubviews(openPostButton, startBackgroundTaskButton)
        
        let constraints = [
            openPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openPostButton.heightAnchor.constraint(equalToConstant: 24),
            
            startBackgroundTaskButton.topAnchor.constraint(equalTo: openPostButton.bottomAnchor, constant: 10),
            startBackgroundTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBackgroundTaskButton.heightAnchor.constraint(equalToConstant: 24),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func openPostButtonTapped() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc private func startBackgroundTaskButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
          resetCalculation()
          updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                             selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
          // register background task
          registerBackgroundTask()
        } else {
          updateTimer?.invalidate()
          updateTimer = nil
          // end background task
          if backgroundTask != .invalid {
            endBackgroundTask()
          }
        }
    }
    
    @objc private func calculateNextNumber() {
      let result = current.adding(previous)
      
      let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
      if result.compare(bigNumber) == .orderedAscending {
        previous = current
        current = result
        position += 1
      } else {
        // This is just too much.... Start over.
        resetCalculation()
      }
      
      let resultsMessage = "Position \(position) = \(current)"
      switch UIApplication.shared.applicationState {
      case .active:
        print(resultsMessage)
      case .background:
        print("App is backgrounded. Next number = \(resultsMessage)")
        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
      case .inactive:
        break
      }
      
    }
    
    private func resetCalculation() {
      previous = .one
      current = .one
      position = 1
    }
    
    @objc func reinstateBackgroundTask() {
      if updateTimer != nil && backgroundTask == .invalid {
        registerBackgroundTask()
      }
    }
    
}
