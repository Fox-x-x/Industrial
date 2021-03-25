//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Delete post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(deletePostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "???"
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "???"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        setupLayout()
        summonTheDevil()
        getPlanet()

    }
    
    private func summonTheDevil() {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/4") {
            NetworkManager.dataTask(url: url) { (data) in
                if let result = data {
                    do {
                        let object = try NetworkManager.JSONToObject(json: result)
                        if let dictionary = object {
                            let toDoItem = ToDoItem(userId: dictionary["userId"] as? Int ?? -1,
                                                    id: dictionary["id"] as? Int ?? -1,
                                                    title: dictionary["title"] as? String ?? "error",
                                                    completed: dictionary["completed"] as? Bool ?? false
                            )
                            DispatchQueue.main.async {
                                self.titleLabel.text = toDoItem.title
                            }
                        }
                    } catch {
                        self.titleLabel.text = "error"
                        handleApiError(error: .other, vc: self)
                    }
                }
            }
        }
        
    }
    
    private func getPlanet() {
        
        if let url = URL(string: "https://swapi.dev/api/planets/1/") {
            NetworkManager.dataTask(url: url) { (data) in
                if let result = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let planet = try? decoder.decode(Planet.self, from: result) {
                        DispatchQueue.main.async {
                            self.planetLabel.text = planet.name + " orbital period: " + planet.orbitalPeriod
                        }
                    }
                }
            }
        }
        
    }
    
    @objc private func deletePostButtonTapped() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        view.addSubviews(deleteButton, titleLabel, planetLabel)
        
        let constraints = [
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 100),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            planetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            planetLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            planetLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            planetLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
