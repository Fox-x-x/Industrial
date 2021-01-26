//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 25.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// Создайте PhotosViewController.swift c одноименным классом внутри.
class PhotosViewController: UIViewController {
    
    weak var flowCoordinator: ProfileCoordinator?
    
    // Добавьте в него экземпляр класса UICollectionView и "растяните" по краям согласно макету.
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self)
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        
        setupLayout()
    }
    
}

// dataSource методы
extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.moviesData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
            for: indexPath
        ) as! PhotosCollectionViewCell
        
        cell.photo = (Storage.moviesData[indexPath.section][indexPath.item] as! String)
        
        return cell
    }
}

// delegate методы
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    // величина отступов
    var offset: CGFloat {
        return 8
    }
    
    // задаем размеры для item в collectionView
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width - offset * 4) / 3
        let height: CGFloat = width
        
        return CGSize(width: width, height: height)
    }
    
    // отсупу между items (горизонтальный)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    // отсуп между строк внутри одной секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return offset
    }
    
    // Добавьте для всей коллекции отступы, используя UIEdgeInsets. Размеры оступов берите из макета.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: .zero, right: offset)
    }
}

// добавляем collectionView на корневую view и задаем констрейнты
private extension PhotosViewController {
    
    func setupLayout() {
        
        view.addSubviewWithAutolayout(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
