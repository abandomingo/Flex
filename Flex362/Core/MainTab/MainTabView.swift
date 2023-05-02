//
//  MainTabView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI

struct MainTabView: View {
    
    
    @State private var selectedIndex = 0
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            TabView(selection: $selectedIndex){
                FeedView()
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem{
                        Image(systemName: "house")
                    }.tag(0)
                CameraView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem{
                        Image(systemName: "camera")
                    }.tag(1)
                ExploreView()
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                    }.tag(2)
                ProfileView(user: user)
                    .onTapGesture {
                        self.selectedIndex = 3
                    }
                    .tabItem{
                        Image(systemName: "person")
                    }.tag(3)
            }
            .navigationTitle(titleForSelection(self.selectedIndex))

        }
    }
}

    func titleForSelection(_ selection: Int) -> String {
        switch selection {
        case 0:
            return "Feed"
        case 2:
            return "Explore"
        default:
            return ""
        }
    }
