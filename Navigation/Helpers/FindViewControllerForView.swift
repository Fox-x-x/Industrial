//
//  FindViewControllerForView.swift
//  Navigation
//
//  Created by Pavel Yurkov on 26.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit


extension UIView {
    /// Определяет какому ViewController принадлежит View
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
