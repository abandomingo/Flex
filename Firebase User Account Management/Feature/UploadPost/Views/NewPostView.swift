//
//  NewPostView.swift
//  Firebase User Account Management
//
//  Created by Aban Domingo on 4/9/23.
//

import SwiftUI

struct NewPostView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Cancel")
                        .bold()
                        .foregroundColor(Color(.systemGray))
                }
                Spacer()
                
                Button{
                    print("Flex") // change to post function
                }label: {
                    Text("Flex")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top){
                Circle()
                    .frame(width: 64, height: 64)
                
                TextArea("Whats happening", text: $caption)
            }
            .padding()
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
