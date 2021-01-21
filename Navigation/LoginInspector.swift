//
//  LoginInspector.swift
//  Navigation
//
//  Created by Pavel Yurkov on 27.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation

// Создаем произвольный класс/структуру LoginInspector (придумайте свое название), который реализует протокол LoginViewControllerDelegate, реализуем в нем протокольные методы.
struct LoginInspector: LoginViewControllerDelegate {
    
    // LoginInspector проверяет точность введенного пароля с помощью синглтона Checker.
    func checkLogin(_ login: String) -> Bool {
        return login == Checker.shared.login
    }
    
    func checkPass(_ pass: String) -> Bool {
        return pass == Checker.shared.pass
    }
    
}
