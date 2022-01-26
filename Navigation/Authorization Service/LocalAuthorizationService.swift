//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Pavel Yurkov on 24.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authorization"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason) { success, error in
                    guard success, error == nil else {
                        // провал
                        authorizationFinished(false)
                        return
                    }
                    // успех
                    authorizationFinished(true)
                }
        } else {
            // нельзя использовать
            authorizationFinished(false)
        }
        
    }
    
}


