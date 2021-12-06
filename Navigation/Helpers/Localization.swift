//
//  Localization.swift
//  Navigation
//
//  Created by Pavel Yurkov on 10.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum Localization {
    case feed, fav, profile, feedTitle,
         openPost, openAnotherPost, music, youTube, timeLeft,
         signOutButton, statusLabelName, statusPlaceholder, showStatusButtonName, photoSectionName, likesLabelName, viewsLabelName,
         searchPlaceholderName,
         mementoName, mementoDescr, prestigeName, prestigeDescr, darkNightName, darkNightDescr, inceptionName, inceptionDescr,
         deletePostButtonName, deletePostAlertName, deletePostAlertDescr, cancel, delete, orbitalPeriod,
         oops, authError, noData, noSong, wrongPass, invalidEmail, signError,
         emailOrPhone, password, loginButtonText
    
    var localizedValue: String {
        switch self {
            case .feed:
                let text = NSLocalizedString("feed", comment: "tabBar tab")
                return text
            case .fav:
                let text = NSLocalizedString("fav", comment: "tabBar tab")
                return text
            case .profile:
                let text = NSLocalizedString("profile", comment: "tabBar tab")
                return text
            case .feedTitle:
                let text = NSLocalizedString("feed-title", comment: "feed title")
                return text
            case .openPost:
                let text = NSLocalizedString("open-post", comment: "Feed VC content")
                return text
            case .openAnotherPost:
                let text = NSLocalizedString("open-another-post", comment: "Feed VC content")
                return text
            case .music:
                let text = NSLocalizedString("music", comment: "Feed VC content")
                return text
            case .youTube:
                let text = NSLocalizedString("youTube", comment: "Feed VC content")
                return text
            case .timeLeft:
                let text = NSLocalizedString("time-left", comment: "Feed VC content")
                return text
            case .signOutButton:
                let text = NSLocalizedString("sign-out", comment: "Profile VC header view")
                return text
            case .statusLabelName:
                let text = NSLocalizedString("status-label", comment: "Profile VC header view")
                return text
            case .statusPlaceholder:
                let text = NSLocalizedString("status-placeholder", comment: "Profile VC header view")
                return text
            case .showStatusButtonName:
                let text = NSLocalizedString("status-button", comment: "Profile VC header view")
                return text
            case .photoSectionName:
                let text = NSLocalizedString("photos", comment: "Profile VC content")
                return text
            case .likesLabelName:
                let text = NSLocalizedString("likes", comment: "Profile VC content")
                return text
            case .viewsLabelName:
                let text = NSLocalizedString("views", comment: "Profile VC content")
                return text
            case .searchPlaceholderName:
                let text = NSLocalizedString("search-placeholder", comment: "Profile VC content")
                return text
            case .mementoName:
                let text = NSLocalizedString("mementoName", comment: "Storage, movies")
                return text
            case .mementoDescr:
                let text = NSLocalizedString("mementoDescr", comment: "Storage, movies")
                return text
            case .prestigeName:
                let text = NSLocalizedString("prestigeName", comment: "Storage, movies")
                return text
            case .prestigeDescr:
                let text = NSLocalizedString("prestigeDescr", comment: "Storage, movies")
                return text
            case .darkNightName:
                let text = NSLocalizedString("darkNightName", comment: "Storage, movies")
                return text
            case .darkNightDescr:
                let text = NSLocalizedString("darkNightDescr", comment: "Storage, movies")
                return text
            case .inceptionName:
                let text = NSLocalizedString("inceptionName", comment: "Storage, movies")
                return text
            case .inceptionDescr:
                let text = NSLocalizedString("inceptionDescr", comment: "Storage, movies")
                return text
            case .deletePostButtonName:
                let text = NSLocalizedString("deletePostButtonName", comment: "delete post vc")
                return text
            case .deletePostAlertName:
                let text = NSLocalizedString("deletePostAlertName", comment: "delete post vc")
                return text
            case .deletePostAlertDescr:
                let text = NSLocalizedString("deletePostAlertDescr", comment: "delete post vc")
                return text
            case .cancel:
                let text = NSLocalizedString("cancel", comment: "delete post vc")
                return text
            case .delete:
                let text = NSLocalizedString("delete", comment: "delete post vc")
                return text
            case .orbitalPeriod:
                let text = NSLocalizedString("orbitalPeriod", comment: "delete post vc")
                return text
            case .oops:
                let text = NSLocalizedString("oops", comment: "ApiErro")
                return text
            case .authError:
                let text = NSLocalizedString("authError", comment: "ApiErro")
                return text
            case .noData:
                let text = NSLocalizedString("noData", comment: "ApiErro")
                return text
            case .noSong:
                let text = NSLocalizedString("noSong", comment: "ApiErro")
                return text
            case .wrongPass:
                let text = NSLocalizedString("wrongPass", comment: "ApiErro")
                return text
            case .invalidEmail:
                let text = NSLocalizedString("invalidEmail", comment: "ApiErro")
                return text
            case .signError:
                let text = NSLocalizedString("signError", comment: "ApiErro")
                return text
            case .emailOrPhone:
                let text = NSLocalizedString("emailOrPhone", comment: "login VC")
                return text
            case .password:
                let text = NSLocalizedString("password", comment: "login VC")
                return text
            case .loginButtonText:
                let text = NSLocalizedString("loginButtonText", comment: "login VC")
                return text
            }
    }
}
