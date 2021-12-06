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
    case songNotFound
    case wrongPassword
    case invalidEmail
    case authError
    case createUserError
    case signOutError
    case userNotFound
}

func handleApiError(error: ApiError, vc: UIViewController) {
    switch error {
    case .other:
        Alert.showAlertError(title: Localization.oops.localizedValue, message: "Произошла неизвестная ошибка", on: vc)
    case .internalError:
        Alert.showAlertError(title: Localization.oops.localizedValue, message: "В приложении произошла внутренняя ошибка", on: vc)
    case .unauthorized:
        Alert.showAlertError(title: Localization.authError.localizedValue, message: "Неправильное имя пользователя или пароль", on: vc)
    case .emptyData:
        Alert.showAlertError(title: Localization.noData.localizedValue, message: "К сожалению, не удалось получить данные с сервера", on: vc)
    case .songNotFound:
        Alert.showAlertError(title: Localization.noSong.localizedValue, message: "К сожалению, не удалось проиграть эту песню, т.к. она отсутствует", on: vc)
    case .wrongPassword:
        Alert.showAlertError(title: Localization.wrongPass.localizedValue, message: "Please check your password and try again", on: vc)
    case .invalidEmail:
        Alert.showAlertError(title: Localization.invalidEmail.localizedValue, message: "The entered email address is malformed", on: vc)
    case .authError:
        Alert.showAlertError(title: Localization.authError.localizedValue, message: "Some auth error occured :(", on: vc)
    case .createUserError:
        Alert.showAlertError(title: Localization.authError.localizedValue, message: "There was a problem creating a user :(", on: vc)
    case .signOutError:
        Alert.showAlertError(title: Localization.signError.localizedValue, message: "There was a problem signing out :(", on: vc)
    case .userNotFound:
        Alert.showAlertError(title: Localization.oops.localizedValue, message: "User not found", on: vc)
    }
    
}
