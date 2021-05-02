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
    var delegate: LoginViewControllerDelegate?
    
    private var user: User
    private var isInFavoritesMode: Bool
    
    private var posts = [Post]()
    
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
    
    init(user: User, isInFavoritesMode: Bool) {
        self.user = user
        self.isInFavoritesMode = isInFavoritesMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    // показываем NavigationBar ровно в тот момент, когда контроллер будет показан юзеру
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initPosts()
        
        if isInFavoritesMode {
            navigationController?.navigationBar.isHidden = false
            title = "Favorites"
        } else {
            navigationController?.navigationBar.isHidden = true
        }
        
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
    
    private func initPosts() {
        
        posts = []
        
        if isInFavoritesMode {
            let coreDataManager = CoreDataStack(modelName: "FavPostModel")
            let favoritePosts = coreDataManager.fetchData(for: FavPost.self)
            
            for favoritePost in favoritePosts {
                if let author = favoritePost.author, let description = favoritePost.descr, let image = favoritePost.image {
                    let post = Post(author: author,
                                    description: description,
                                    image: image,
                                    likes: Int(favoritePost.likes),
                                    views: Int(favoritePost.views),
                                    index: Int(favoritePost.index)) // костыль, т.к. Storage статичный
                    posts.append(post)
                }
            }
        } else {
            posts = Storage.moviesData
        }
        
        tableView.reloadData()
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
    
    // т.к. Storage хранилище статично, то нужна функция-костыль, которая предотвращает добавление дубликатов в избранное
    private func isPostInFavorites(post: Post, coreDataManager: CoreDataStack) -> Bool {
        
        let favoritePosts = coreDataManager.fetchData(for: FavPost.self)
        
        for favoritePost in favoritePosts {
            if favoritePost.index == post.index {
                return true
            }
        }
        return false
    }
    
    @objc private func userPostTapped(sender: CustomTapGestureRecognizer) {
        
        guard let itemIndex = sender.indexPath?.row else { return }
        
        let selectedPost = posts[itemIndex]
        let coreDataManager = CoreDataStack(modelName: "FavPostModel")
        
        if !isPostInFavorites(post: selectedPost, coreDataManager: coreDataManager) {
            let favoritePost = coreDataManager.createObject(from: FavPost.self)
            
            favoritePost.author = selectedPost.author
            favoritePost.descr = selectedPost.description
            favoritePost.image = selectedPost.image
            favoritePost.likes = Int16(selectedPost.likes)
            favoritePost.views = Int16(selectedPost.views)
            favoritePost.index = Int16(selectedPost.index)
            
            let context = coreDataManager.getContext()
            coreDataManager.save(context: context)
        }
        
    }

}

// dataSource методы
extension ProfileViewController: UITableViewDataSource {
    
    // кол-во секций
    func numberOfSections(in tableView: UITableView) -> Int {
        if isInFavoritesMode {
            return 1
        } else {
            return 2
        }
        
    }
    
    // кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInFavoritesMode {
            return posts.count
        } else {
            // если это нулевая секция, в которой должна быть всего 1 ячейка с 4 фото
            if section == 0 {
                return 1
            } else {
                // в остальных случаях
                return posts.count
            }
        }
        
    }
    
    // создаем и наполняем ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            // секция, в которой лежит ячейка с 4 фото
            if indexPath.section == 0 && isInFavoritesMode == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
                
                cell.photos = getPhotosFromStorage(Storage.photos)
                
                return cell
                
            } else {
                // остальные секции с постами (по факту на данный момент всего 1 секция)
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
                    
                cell.post = posts[indexPath.row]
                
                if !isInFavoritesMode {
                    let tapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(userPostTapped(sender:)))
                    tapGestureRecognizer.numberOfTapsRequired = 2
                    tapGestureRecognizer.indexPath = indexPath
                    cell.addGestureRecognizer(tapGestureRecognizer)
                }
                
                // делаем разделитель строк на всю ширину экрана, чтоб красивее смотрелось :)
                cell.preservesSuperviewLayoutMargins = false
                cell.separatorInset = UIEdgeInsets.zero
                cell.layoutMargins = UIEdgeInsets.zero
                
                return cell
            }
        
    }
    
    // подключаем header для секции, в котором содержится инфо профиля (аватар, статус, итд.)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard isInFavoritesMode == false else { return nil }
        guard section == 0 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        print("section = \(section)")
        
        header.onTap = { [weak self] in
            print("sign out")
            if let vc = self {
                if let loginDelegate = vc.delegate {
                    loginDelegate.signOut(user: vc.user)
                    vc.flowCoordinator?.goToLogin()
                }
            }
        }

        return header
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            flowCoordinator?.goToPhotos()
        }
    }
    
}
