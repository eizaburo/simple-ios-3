//
//  ContentView.swift
//  practice-ios-1
//
//  Created by Eizaburo Tamaki on 2025/08/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            ContactView()
                .tabItem{
                    Image(systemName: "envelope")
                    Text("Contact")
                }
        }
    }
}

#Preview {
    ContentView()
}
