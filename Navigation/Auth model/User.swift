//
//  User.swift
//  Navigation
//
//  Created by Pavel Yurkov on 21.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class User: Object {
    
    dynamic var email: String = ""
    dynamic var password: String = ""
    dynamic var wasLogedIn: Bool = false
    
}
