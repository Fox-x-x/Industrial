//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    weak var flowCoordinator: ProfileCoordinator?
    
    // tableView
    // Добавьте экземпляр класса UITableView и закрепите его к краям экрана.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
    }
    
    // показываем NavigationBar ровно в тот момент, когда контроллер будет показан юзеру
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // отдельная функция для добавления view и настройки layout
    private func setupLayout() {
        
        view.addSubviewWithAutolayout(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // получает 4 фото (или сколько есть) из массива с фото для ячейки, которая должна содержать 4 фото
    private func getPhotosFromStorage(_ storage: [String]) -> [String] {
        var photos = [String]()
        
        if !storage.isEmpty {
            for photo in storage {
                photos.append(photo)
                if photos.count == 4 {
                    break
                }
            }
        }
        return photos
    }

}

// dataSource методы
extension ProfileViewController: UITableViewDataSource {
    
    // кол-во секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return Storage.moviesData.count
    }
    
    // кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // если это нулевая секция, в которой должна быть всего 1 ячейка с 4 фото
        if section == 0 {
            return 1
        } else {
            // в остальных случаях
            return Storage.moviesData[section].count
        }
        
    }
    
    // создаем и наполняем ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // секция, в которой лежит ячейка с 4 фото
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            
            cell.photos = getPhotosFromStorage(Storage.moviesData[indexPath.section] as! [String])
            
            return cell
            
        } else {
            // остальные секции с постами (по факту на данный момент всего 1 секция)
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
                
            cell.post = Storage.moviesData[indexPath.section][indexPath.row] as? Post
            
            // делаем разделитель строк на всю ширину экрана, чтоб красивее смотрелось :)
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            return cell
        }
        
    }
    
    // подключаем header для секции, в котором содержится инфо профиля (аватар, статус, итд.)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard section == 0 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        print("section = \(section)")

        return header
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            flowCoordinator?.goToPhotos()
        }
    }
    
}
