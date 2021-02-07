//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Pavel Yurkov on 31.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class PhotosModel: NSObject {
    func getPhotosFromServer(completion: ([String]) -> Void) {
        completion(Storage.photos)
    }
}
