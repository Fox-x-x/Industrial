//
//  Errors.swift
//  Navigation
//
//  Created by Pavel Yurkov on 07.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

enum ApiError: Error {
    case unauthorized
    case other
    case internalError
    case emptyData
}

func handleApiError(error: ApiError, vc: UIViewController) {
    switch error {
    case .other:
        Alert().showAlertError(title: "Oops!", message: "Произошла неизвестная ошибка", on: vc)
        print("We have some problems with our server")
    case .internalError:
        Alert().showAlertError(title: "Oops!", message: "В приложении произошла внутренняя ошибка", on: vc)
        print("We have some problems with data parsing")
    case .unauthorized:
        Alert().showAlertError(title: "Ошибка авторизации", message: "Неправильное имя пользователя или пароль", on: vc)
        print("We have some problems with authorization token")
    case .emptyData:
        Alert().showAlertError(title: "Empty data", message: "We got the empty data", on: vc)
        print("We got the empty data")
    }
}
