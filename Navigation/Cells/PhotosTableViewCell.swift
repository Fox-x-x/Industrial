//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 22.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

// Создайте PhotosTableViewCell.swift c одноименным классом внутри.
class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photoImageViews: [UIImageView] = [firstPhoto, secondPhoto, thirdPhoto, fourthPhoto]
    
    var photos: [String]? {
        didSet {
            guard let photos = photos else { return }
            
            // запихиваем первые 4 (или сколько есть) фото в имеющиеся для этих целей UIImageView
            for (index, value) in photos.enumerated() {
                photoImageViews[index].image = UIImage(named: value)
            }
        }
    }
    
    // Сделайте верстку согласно макету. В ячейке должно отображаться первые 4 фото.
    // Первое фото
    private lazy var firstPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Второе фото
    private lazy var secondPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Третье фото
    private lazy var thirdPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Четвертое фото
    private lazy var fourthPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // label с текстом "Photos"
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Photos"
        return label
    }()
    
    // стрелка
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "arrow")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: вычисляем ширину для каждой фото в ячейке
    private lazy var padding: CGFloat = 12
    private lazy var availableWidthForPhotos = UIScreen.main.bounds.width - padding * 2
    private lazy var numberOfPhotos = 4
    private lazy var inset: CGFloat = 8
    private lazy var numberOfInsets = numberOfPhotos - 1
    
    private lazy var photoWidth = CGFloat((Int(availableWidthForPhotos) - numberOfInsets * Int(inset)) / numberOfPhotos)
    
}

// MARK: Layout
private extension PhotosTableViewCell {
    func setupLayout() {
        
        let views = [photosLabel, arrowImage, firstPhoto, secondPhoto, thirdPhoto, fourthPhoto]
        views.forEach { contentView.addSubview($0) }
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        arrowImage.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(photosLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        firstPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(photoWidth)
            make.height.equalTo(firstPhoto.snp.width)
            make.bottom.equalToSuperview().offset(-12)
        }
        secondPhoto.snp.makeConstraints { (make) in
            make.top.width.height.bottom.equalTo(firstPhoto)
            make.leading.equalTo(firstPhoto.snp.trailing).offset(inset)
        }
        thirdPhoto.snp.makeConstraints { (make) in
            make.top.width.height.bottom.equalTo(firstPhoto)
            make.leading.equalTo(secondPhoto.snp.trailing).offset(inset)
        }
        fourthPhoto.snp.makeConstraints { (make) in
            make.top.width.height.bottom.equalTo(firstPhoto)
            make.leading.equalTo(thirdPhoto.snp.trailing).offset(inset)
            make.trailing.equalToSuperview().offset(-12)
        }
        
    }
    
}
