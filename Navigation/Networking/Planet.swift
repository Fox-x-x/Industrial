//
//  Planet.swift
//  Navigation
//
//  Created by Pavel Yurkov on 25.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Planet: Codable {
    
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod
        case orbitalPeriod
        case diameter, climate, gravity, terrain
        case surfaceWater
        case population, residents, films, created, edited, url
    }
}
