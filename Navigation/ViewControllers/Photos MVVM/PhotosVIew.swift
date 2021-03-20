//
//  PhotosVIew.swift
//  Navigation
//
//  Created by Pavel Yurkov on 31.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosView: UIViewController {
    
    weak var flowCoordinator: ProfileCoordinator?
    var photoCollection: [String]?
    
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
    
    private var vm: PhotosViewModel
    
    init(vm: PhotosViewModel) {
        
        self.vm = vm
        
        super.init(nibName: nil, bundle: nil)
        
        setupView()
        setupLayout()
        setupViewModel()
        vm.getPhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubviewWithAutolayout(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateViewWith(photos: [String]) {
        photoCollection = photos
    }
    
    func setupViewModel() {
        vm.photosFromServerDidRecieved = { [weak self] photos in
            self?.updateViewWith(photos: photos)
        }
    }
}

// dataSource методы
extension PhotosView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
            for: indexPath
        ) as! PhotosCollectionViewCell
        
        cell.photo = (photoCollection?[indexPath.item])
        
        return cell
    }
}

// delegate методы
extension PhotosView: UICollectionViewDelegateFlowLayout {
    
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
