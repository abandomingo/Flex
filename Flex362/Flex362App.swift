//
//  Flex362App.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI
import Firebase

@main
struct Flex362App: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
