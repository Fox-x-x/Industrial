//
//  Checker.swift
//  Navigation
//
//  Created by Pavel Yurkov on 26.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation

struct Checker {
    
    let login = "Pavel"
    let pass = "pavel"
    
    static let shared: Checker = {
        let instance = Checker()
        return instance
    }()
    
    private init() {
        
    }
    
    func checkLoginAndPass() {
    }
}
