//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Pavel Yurkov on 31.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class PhotosViewModel: NSObject {
    
    private var model: PhotosModel
    
    var photos: [String] {
        didSet {
            photosFromServerDidRecieved?(photos)
        }
    }
    
    var photosFromServerDidRecieved: (([String]) -> Void)?
    
    init(model: PhotosModel, photos: [String]) {
        self.model = model
        self.photos = photos
    }
    
    func getPhotos() {
        model.getPhotosFromServer { [weak self] (photos) in
            self?.photos = photos
        }
    }
}
