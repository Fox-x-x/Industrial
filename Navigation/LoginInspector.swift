//
//  LoginInspector.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(_ login: String) -> Bool {
        return login == Checker.shared.login
    }
    
    func checkPass(_ pass: String) -> Bool {
        return pass == Checker.shared.pass
    }
    
}
