//
//  Alerts.swift
//  Navigation
//
//  Created by Pavel Yurkov on 08.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class Alert {

    class func showAlertError(title: String, message: String, on viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { _ in
            
        }
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
}
