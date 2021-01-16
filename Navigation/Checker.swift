//
//  Checker.swift
//  Navigation
//
//  Created by Pavel Yurkov on 26.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import Foundation

// Создаем Singleton с названием Checker (или любым другим), с 1 методом для проверки логина и пароля. Singleton - класс или структура, на ваш выбор. Пусть свойства (логин и пароль) существуют в hardcode виде, по выбору студента (let login = "Vasily", let pswd = "Masha" и тд)
struct Checker {
    
    let login = "Pavel"
    let pass = "pavel"
    
    static let shared: Checker = {
        let instance = Checker()
        return instance
    }()
    
    func checkLoginAndPass() {
        // не понимаю зачем это нужно:)
    }
}
