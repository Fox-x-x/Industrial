//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    weak var flowCoordinator: ProfileCoordinator?
    var delegate: LoginViewControllerDelegate?
    
    private var user: User
    private var isInFavoritesMode: Bool
    
    private var posts = [Post]()
    
    private let notificationCenter = NotificationCenter.default
    private let coreDataManager = CoreDataStack()
    private lazy var context = coreDataManager.context
    private lazy var backgroundContext = coreDataManager.backgroundContext
    
    private var fetchResultsController: NSFetchedResultsController<FavPost>?
    
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "search by author"
        return searchBar
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
        
        view.backgroundColor = .white

        setupLayout()
        
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
        
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = false
        
        var constraints = [NSLayoutConstraint]()
        
        if isInFavoritesMode {
            
            view.addSubviewWithAutolayout(tableView)
            view.addSubviewWithAutolayout(searchBar)
            
            constraints = [
                searchBar.topAnchor.constraint(equalTo: view.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 44),
                
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
            
        } else {
            
            view.addSubviewWithAutolayout(tableView)
            
            constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
            
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initPosts(with request: NSFetchRequest<FavPost> = FavPost.fetchRequest()) {
        
        posts = []
        
        if isInFavoritesMode {
            
            let nameSort = NSSortDescriptor(key: #keyPath(FavPost.authorNormalized), ascending: true)
            request.sortDescriptors = [nameSort]
            fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController?.delegate = self
            
            do {
                try fetchResultsController?.performFetch()
            } catch {
                assertionFailure()
            }
            
            let favoritePosts = fetchResultsController?.fetchedObjects
            
            if let favPosts = favoritePosts {
                // конвертируем то, что получили из CoreData, в Post, т.к. основное хранилище (Storage) у нас статично и хранится в таком виде.
                for favoritePost in favPosts {
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
    private func isPostInFavorites(post: Post) -> Bool {
        
//        let favoritePosts = coreDataManager.fetchData(for: FavPost.self, with: context)
        let favoritePosts = fetchResultsController?.fetchedObjects
        
        if let favoritePosts = favoritePosts {
            for favoritePost in favoritePosts {
                if favoritePost.index == post.index {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func getPost(from arrayOfPosts: [FavPost], withIndex index: Int) -> FavPost? {
        
        for post in arrayOfPosts {
            if post.index == index {
                return post
            }
        }
        return nil
    }
    
    @objc private func userPostTapped(sender: CustomTapGestureRecognizer) {
        
        guard let itemIndex = sender.indexPath?.row else { return }
        
        let selectedPost = posts[itemIndex]
        
        if !isPostInFavorites(post: selectedPost) {
            let favoritePost = coreDataManager.createObject(from: FavPost.self, with: backgroundContext)
            
            favoritePost.author = selectedPost.author
            favoritePost.descr = selectedPost.description
            favoritePost.image = selectedPost.image
            favoritePost.likes = Int16(selectedPost.likes)
            favoritePost.views = Int16(selectedPost.views)
            favoritePost.index = Int16(selectedPost.index)
            
            let transformer = StringTransform("Latin; Lower")
            favoritePost.authorNormalized = favoritePost.author?.applyingTransform(transformer, reverse: false)
            
            notificationCenter.addObserver(forName: .NSManagedObjectContextDidSave, object: backgroundContext, queue: nil) { [weak self] notification in
                if let vc = self {
                    vc.context.perform {
                        vc.context.mergeChanges(fromContextDidSave: notification)
                    }
                }
            }
            
            coreDataManager.save(context: backgroundContext)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if isInFavoritesMode {
            
            let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                
                if let vc = self, let favoritePosts = vc.fetchResultsController?.fetchedObjects {
                    
                    if let postToDelete = vc.getPost(from: favoritePosts, withIndex: vc.posts[indexPath.row].index) {                        
                        vc.coreDataManager.delete(object: postToDelete, with: vc.context)
                        completionHandler(true)
                    }
                    
                }
                
            }
            
            delete.image = UIImage(systemName: "trash")
            delete.backgroundColor = .systemRed
            
            let swipe = UISwipeActionsConfiguration(actions: [delete])
            
            return swipe
        }
        
        return nil
        
    }
    
}

// MARK: - Search bar methods
extension ProfileViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text {
            
            let request: NSFetchRequest<FavPost> = FavPost.fetchRequest()
            request.predicate = NSPredicate(format: "authorNormalized MATCHES[cd] %@", searchText)
            
            initPosts(with: request)
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            initPosts()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

extension ProfileViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        
        case .insert:
            print("insert")
            
        case .delete:
            print("notification: delete")
            if let indexPath = indexPath {
                posts.remove(at: indexPath.row)
                tableView.performBatchUpdates {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
        case .move:
            print("move")
        case .update:
            print("update")
        @unknown default:
            print("default")
        }
    }
}
