//
//  CustomInputField.swift
//  Flex362
//
//  Created by Aban Domingo on 4/21/23.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    
    var body: some View {
        
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:20, height: 20)
                    .foregroundColor(Color(.black))
                
                if isSecureField ?? false{
                    SecureField(placeholderText,text: $text)
                        .foregroundColor(.black)
                }else {
                    
                    TextField(placeholderText,text: $text)
                        .foregroundColor(.black)
                }
            }
            
            Divider()
                .background(Color(.black))
            
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         isSecureField: false,
                         text: .constant(""))
    }
}
