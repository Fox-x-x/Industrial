//
//  Storage.swift
//  Navigation
//
//  Created by Pavel Yurkov on 18.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation

struct Storage {
    
    static let moviesData = [
        Post(author: Localization.mementoName.localizedValue, description: Localization.mementoDescr.localizedValue, image: "memento", likes: 372, views: 791, index: 0),
        Post(author: Localization.prestigeName.localizedValue, description: Localization.prestigeDescr.localizedValue, image: "Prestige", likes: 481, views: 813, index: 1),
        Post(author: Localization.darkNightName.localizedValue, description: Localization.darkNightDescr.localizedValue, image: "The-Dark-Knight", likes: 631, views: 976, index: 2),
        Post(author: Localization.inceptionName.localizedValue, description: Localization.inceptionDescr.localizedValue, image: "Inception", likes: 433, views: 521, index: 3)
    ]
    
    static let photos = [
        "pirates", "matrix", "eternal_sunshine", "pulp_fiction", "beauty", "time", "her", "pretty", "inception-2", "leon", "knifes", "future", "black", "shining", "it", "club", "lamb", "home", "redemption", "moon"
    ]
}
