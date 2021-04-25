//
//  LoginInspector.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

final class LoginInspector: LoginViewControllerDelegate {
    
    let realm = try? Realm()
    
    // MARK: Realm methods
    func addUser(email: String, pass: String) -> User {
        
        let user = User()
        
        user.email = email
        user.password = pass
        user.wasLogedIn = true
        
        try? realm?.write {
            realm?.add(user)
            print("user has been added!")
        }
        return user
    }
    
    func findUser(email: String) -> User? {
        
        let usersArray = realm?.objects(User.self)
        
        if let users = usersArray {
            for user in users {
                if user.email == email {
                    return user
                }
            }
        }
        return nil
    }
    
    func loginOrRegisterUser(email: String, pass: String) throws -> User {
        
        let user = findUser(email: email)
        
        if let foundUser = user {
            if foundUser.password == pass {
                try? realm?.write {
                    foundUser.wasLogedIn = true
                }
                return foundUser
            } else {
                throw ApiError.wrongPassword
            }
        } else {
            print("User wasn't found")
            let newUser = addUser(email: email, pass: pass)
            return newUser
        }
    }
    
    func signOut(user: User) {
        try? realm?.write {
            user.wasLogedIn = false
        }
    }
    
}
