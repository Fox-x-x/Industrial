//
//  AutoLayout.swift
//  Navigation
//
//  Created by Pavel Yurkov on 03.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
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
