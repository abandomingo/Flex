//
//  LoginView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI

struct LoginView: View {
    
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {

    ZStack{
            Image("login")
                .resizable()
            
        VStack{
            Text("Welcome to Flex")
                .font(.system(size: 64))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 text: $email)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .foregroundColor(Color(.darkGray))
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .foregroundColor(Color(.darkGray))
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack{
                Spacer()
                NavigationLink{
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.trailing,24)
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            VStack(alignment: .trailing) {
                Button{
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(Color(.black))
                        .frame(width: 340, height: 50)
                        .background(Color(.white))
                        .cornerRadius(100)
                }
                
                NavigationLink{
                    RegistrationView()
                } label: {
                    Text("Register ")
                        .font(.headline)
                        .foregroundColor(Color(.black))
                        .frame(width: 340, height: 50)
                        .background(Color(.systemGray2))
                        .cornerRadius(100)
                }
            }
            
            
            
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
