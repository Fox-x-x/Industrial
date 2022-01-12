//
//  LoginView.swift
//  Navigation
//
//  Created by Pavel Yurkov on 08.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                LoginAndPassFields()
                    .offset(y: 100)
                
                Button(action: {
                    print("login button tapped")
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing], 24)
                .offset(y: 80)
                
            }
            .offset(y: 120)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
