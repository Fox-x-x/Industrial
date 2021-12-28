//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 22.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

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
        label.textColor = UIColor.createColor(lightMode: ColorPalette.fourthColorLight, darkMode: ColorPalette.fourthColorDark)
        label.numberOfLines = 1
        label.text = Localization.photoSectionName.localizedValue
        return label
    }()
    
    // стрелка
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = UIColor.createColor(lightMode: ColorPalette.fourthColorLight, darkMode: ColorPalette.fourthColorDark)
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
        
        contentView.addSubviews(photosLabel, arrowImage, firstPhoto, secondPhoto, thirdPhoto, fourthPhoto)
        
        let constraints = [
            
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 24),
            arrowImage.widthAnchor.constraint(equalToConstant: 30),
            
            firstPhoto.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            firstPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            firstPhoto.widthAnchor.constraint(equalToConstant: photoWidth),
            firstPhoto.heightAnchor.constraint(equalTo: firstPhoto.widthAnchor),
            firstPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            secondPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            secondPhoto.leadingAnchor.constraint(equalTo: firstPhoto.trailingAnchor, constant: inset),
            secondPhoto.widthAnchor.constraint(equalTo: firstPhoto.widthAnchor),
            secondPhoto.heightAnchor.constraint(equalTo: firstPhoto.heightAnchor),
            secondPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor),
            
            thirdPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            thirdPhoto.leadingAnchor.constraint(equalTo: secondPhoto.trailingAnchor, constant: inset),
            thirdPhoto.widthAnchor.constraint(equalTo: firstPhoto.widthAnchor),
            thirdPhoto.heightAnchor.constraint(equalTo: firstPhoto.heightAnchor),
            thirdPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor),
            
            fourthPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            fourthPhoto.leadingAnchor.constraint(equalTo: thirdPhoto.trailingAnchor, constant: inset),
            fourthPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            fourthPhoto.widthAnchor.constraint(equalTo: firstPhoto.widthAnchor),
            fourthPhoto.heightAnchor.constraint(equalTo: firstPhoto.heightAnchor),
            fourthPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
