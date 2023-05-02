//
//  RegistrationView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack{
                Image("register")
                    .resizable()
                
            VStack{
                
                NavigationLink(destination: ProfilePhotoSelectorView(),
                               isActive: $viewModel.didAuthenticateUser,
                               label: { })
                Text("Create your Account")
                    .font(.system(size: 64))
                    .foregroundColor(.white)
                    .bold()
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
                    CustomInputField(imageName: "person",
                                     placeholderText: "Username",
                                     text: $username)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .foregroundColor(Color(.darkGray))
                    CustomInputField(imageName: "person",
                                     placeholderText: "Full Name",
                                     text: $fullname)
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
                
                Spacer()
                    .frame(height: 50)
                
                VStack(alignment: .trailing) {
                    Button{
                        viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
                    } label: {
                        Text("Register ")
                            .font(.headline)
                            .foregroundColor(Color(.black))
                            .frame(width: 340, height: 50)
                            .background(Color(.systemGray2))
                            .cornerRadius(100)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Already have an account?")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }
                
                
                
                }
            .navigationBarBackButtonHidden()
            }
            .ignoresSafeArea()
        }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
