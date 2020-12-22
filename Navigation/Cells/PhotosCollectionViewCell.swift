//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 26.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

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
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
