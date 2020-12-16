//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Pavel Yurkov on 18.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            
            authorLabel.text = post.author
            postImage.image = UIImage(named: post.image)
            descriptionLabel.text = post.description
            likesLabel.text = "Likes: " + String(post.likes)
            viewsLabel.text = "Views: " + String(post.views)
            
        }
    }

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private let likesLabel: UILabel = {
        let likes = UILabel()
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    private let viewsLabel: UILabel = {
        let views = UILabel()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        return views
    }()
    
    // MARK: Init
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
        
        let views = [authorLabel, postImage, descriptionLabel, likesLabel, viewsLabel]
        views.forEach { contentView.addSubview($0) }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(16)
        }
        
        postImage.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.width.height.equalTo(UIScreen.main.bounds.width)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImage.snp.bottom).offset(16)
            make.leading.equalTo(authorLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalTo(authorLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        viewsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(likesLabel.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(likesLabel.snp.bottom)
        }
    }
}
