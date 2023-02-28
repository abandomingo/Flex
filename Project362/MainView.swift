//
//  MainView.swift
//  Project332
//
//  Created by Aban Domingo on 2/15/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            CameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera.fill")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Valeria", systemImage: "person.fill")
                    Label("Valeria", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home Feed")
    }
}

struct CameraView: View {
    var body: some View {
        Text("Camera Screen")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
    }
}

