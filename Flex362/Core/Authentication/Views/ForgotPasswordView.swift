//
//  ForgotPasswordView.swift
//  Flex362
//
//  Created by Aban Domingo on 5/1/23.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    
    @State private var message = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Image("login")
                .resizable()
            VStack(spacing: 40){
                
                Text("Forgot Your Password?")
                    .font(.system(size: 64))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 text: $email)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .foregroundColor(Color(.darkGray))
                
                Text(message)
                    .foregroundColor(.white)
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back to Login")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemGray2))
                        .cornerRadius(100)
                }

                
                Button {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            message = "The email was not found"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                message = ""
                            }
                        } else {
                            message = "Request has been sent to your email"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                message = ""
                            }
                        }
                    }
                } label: {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(Color(.black))
                        .frame(width: 340, height: 50)
                        .background(Color(.gray))
                        .cornerRadius(100)
                }
            }
            .padding()
        .navigationBarBackButtonHidden()
        }
        .ignoresSafeArea()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
