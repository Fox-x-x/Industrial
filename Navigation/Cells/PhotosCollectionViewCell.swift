//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 26.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// Создайте PhotosCollectionViewCell.swift с одноименным классом внутри.
final class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: String? {
        didSet {
            guard let photo = photo else { return }
            photoImageView.image = UIImage(named: photo)
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    // для сториборд и XIB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// добавляем photoImageView в корневую contentView и задаем констрейнты
private extension PhotosCollectionViewCell {
    func setupLayout() {
        contentView.backgroundColor = UIColor.createColor(lightMode: ColorPalette.secondaryColorLight, darkMode: ColorPalette.secondaryColorDark)
        
        contentView.addSubviewWithAutolayout(photoImageView)
        
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
