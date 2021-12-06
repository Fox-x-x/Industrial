//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 18.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// Создайте файл 'PostTableViewCell.swift' и добавьте в него класс UITableViewCell с именем 'PostTableViewCell'.
class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            
            authorLabel.text = post.author
            postImage.image = UIImage(named: post.image)
            descriptionLabel.text = post.description
            likesLabel.text = Localization.likesLabelName.localizedValue + String(post.likes)
            viewsLabel.text = Localization.viewsLabelName.localizedValue + String(post.views)
            
        }
    }
    
    // здесь создаем все элементы интерфейса поста: картинка, текст, лайки, итд.
    // имя автора
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    // текст поста
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    // картинка поста
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    // лайки
    private let likesLabel: UILabel = {
        let likes = UILabel()
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    // просмотры
    private let viewsLabel: UILabel = {
        let views = UILabel()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        return views
    }()
    
    // init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Layout
private extension PostTableViewCell {
    func setupLayout() {
        
        // добавляем всё в корневую contentView
        contentView.addSubviews(authorLabel, postImage, descriptionLabel, likesLabel, viewsLabel)
        
        // задаем констрейнты
        let constraints = [
            
            // автор поста
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // картинка поста
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            // текст поста
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // лайки
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            // просмотры
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
