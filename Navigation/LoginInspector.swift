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
        if login == Checker.shared.login {
            return true
        } else {
            return false
        }
    }
    
    func checkPass(_ pass: String) -> Bool {
        if pass == Checker.shared.pass {
            return true
        } else {
            return false
        }
    }
    
    // Вопрос:) В задании есть еще вот такой пункт. Не понял для чего он:
    // Важный момент: чтобы делегат мог вернуть контроллеру результат проверки логина и пароля, в методах протокола делегата должны быть коллбэки/замыкания
    
}
