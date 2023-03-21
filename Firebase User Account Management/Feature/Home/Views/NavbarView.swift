//
//  NavbarView.swift
//  Firebase User Account Management
//
//  Created by Aban Domingo on 3/6/23.
//

import SwiftUI

struct NavbarView: View{
    
    @EnvironmentObject var service: SessionServiceImpl
    
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            CameraView()
            Text("Camera")
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
            BioView()
            Text("Bio")
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")

                }
        }
    }
}
struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
