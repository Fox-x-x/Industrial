//
//  TabView.swift
//  Navigation
//
//  Created by Pavel Yurkov on 10.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
    
    var body: some View {
        TabView {
            LoginView()
                .tabItem {
                    Label("Menu", systemImage: "house.fill")
                }

            LoginView()
                .tabItem {
                    Label("Order", systemImage: "person.fill")
                }
            
            LoginView()
                .tabItem {
                    Label("Order", systemImage: "music.note")
                }
            
            LoginView()
                .tabItem {
                    Label("Order", systemImage: "video.fill")
                }
            
            LoginView()
                .tabItem {
                    Label("Order", systemImage: "mic.fill")
                }
        }
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
