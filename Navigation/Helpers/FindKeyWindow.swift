//
//  FindKeyWindow.swift
//  Navigation
//
//  Created by Pavel Yurkov on 02.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
