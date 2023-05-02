//
//  ContentView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession == nil{
                // no use found
                LoginView()
            }else{
                // have a logged in user
                MainTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
    }
}

    
