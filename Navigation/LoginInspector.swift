//
//  LoginInspector.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase

final class LoginInspector: LoginViewControllerDelegate {
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            print("signed out succsessfuly")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            throw ApiError.signOutError
        }
    }
    
    func registerUser(email: String, pass: String, completion: @escaping (Result<User, ApiError>) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
            if error != nil {
                print("can not create user")
                completion(.failure(.createUserError))
            } else {
                if let createdUser = authResult?.user {
                    completion(.success(createdUser))
                } else {
                    completion(.failure(.authError))
                }
            }
        }
    }
    
    func loginOrRegisterUser(email: String, pass: String, completion: @escaping (Result<User, ApiError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if error != nil {
                if let error = error as NSError? {
                    if let errorCode = AuthErrorCode(rawValue: error.code) {
                        switch errorCode {
                        case .userNotFound:
                            // register new user
                            print("user not found")
                            strongSelf.registerUser(email: email, pass: pass) { (result) in
                                switch result {
                                case .failure(let error):
                                    completion(.failure(error))
                                case .success(let user):
                                    completion(.success(user))
                                }
                            }
                        case .wrongPassword:
                            // alert
                            print("wrong password")
                            completion(.failure(.wrongPassword))
                        case .invalidEmail:
                            // alert
                            print("invalid email")
                            completion(.failure(.invalidEmail))
                        default:
                            // alert
                            print("other error: \(error.localizedDescription)")
                            completion(.failure(.authError))
                        }
                    }
                } else {
                    // alert
                    print("there was an error")
                    completion(.failure(.authError))
                }
            } else {
                // goToProfile
                print("user has been logged in")
                if let loggedInUser = authResult?.user {
                    completion(.success(loggedInUser))
                } else {
                    print("other error: cannot get user from FireBase")
                    completion(.failure(.authError))
                }
            }
            
        }
    }
    
}
