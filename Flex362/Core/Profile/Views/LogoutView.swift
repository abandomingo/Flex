//
//  LogoutView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/23/23.
//

import SwiftUI

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Are you sure you would like to Logout?")
            
            HStack(){
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(Color(.white))
                        .frame(width: 100, height: 50)
                        .background(Color(.darkGray))
                        .cornerRadius(100)
                }
                Button{
                    viewModel.signOut()
                }label: {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(Color(.black))
                        .frame(width: 100, height: 50)
                        .background(Color(.systemGray2))
                        .cornerRadius(100)
                }
                
            }
        }
    }
}

//struct LogoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogoutView()
//    }
//}
