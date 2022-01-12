//
//  RoundeCornersSwiftUI.swift
//  Navigation
//
//  Created by Pavel Yurkov on 09.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
