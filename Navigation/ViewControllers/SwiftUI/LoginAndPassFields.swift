//
//  LoginAndPassFields.swift
//  Navigation
//
//  Created by Pavel Yurkov on 08.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import SwiftUI

struct LoginAndPassFields: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                
                TextField(
                    "email or phone",
                    text: $login
                )
                    .modifier(LoginTextFieldPaddingAndBackColor())
                    .background(
                        RoundedCornersShape(corners: [.topLeft, .topRight], radius: 15)
                            .fill(Color(UIColor.systemGray6))
                    )
                
                Divider()
                    .background(Color(UIColor.lightGray.cgColor))
                
                TextField(
                    "pass",
                    text: $password
                )
                    .modifier(LoginTextFieldPaddingAndBackColor())
                    .background(
                        RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 15)
                            .fill(Color(UIColor.systemGray6))
                    )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(UIColor.lightGray.cgColor), lineWidth: 0.5)
            )
            
        }
        .padding(24)
    }
}

struct LoginTextFieldPaddingAndBackColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(14)
            .foregroundColor(Color(UIColor.createColor(lightMode: ColorPalette.secondaryColorLight, darkMode: ColorPalette.secondaryColorDark).cgColor))
    }
    
}

struct MainTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(Color.black)
    }
}

struct RegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
    }
}

struct LoginAndPassFields_Previews: PreviewProvider {
    static var previews: some View {
        LoginAndPassFields()
    }
}
