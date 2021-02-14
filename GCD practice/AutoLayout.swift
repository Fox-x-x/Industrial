//
//  AutoLayout.swift
//  GCD practice
//
//  Created by Pavel Yurkov on 14.02.2021.
//

import UIKit

extension UIView {
    func addSubviewWithAutolayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
