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
    case .internalError:
        Alert().showAlertError(title: "Oops!", message: "В приложении произошла внутренняя ошибка", on: vc)
    case .unauthorized:
        Alert().showAlertError(title: "Ошибка авторизации", message: "Неправильное имя пользователя или пароль", on: vc)
    case .emptyData:
        Alert().showAlertError(title: "Нет данных", message: "К сожалению, не удалось получить данные с сервера", on: vc)
    }
}
