//
//  FavPost+CoreDataProperties.swift
//  Navigation
//
//  Created by Pavel Yurkov on 02.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension FavPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavPost> {
        return NSFetchRequest<FavPost>(entityName: "FavPost")
    }

    @NSManaged public var author: String?
    @NSManaged public var descr: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int16
    @NSManaged public var views: Int16
    @NSManaged public var index: Int16

}

extension FavPost : Identifiable {

}
