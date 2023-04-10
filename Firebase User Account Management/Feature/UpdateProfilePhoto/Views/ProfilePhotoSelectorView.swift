//
//  ProfilePhotoSelectorView.swift
//  Firebase User Account Management
//
//  Created by Aban Domingo on 4/9/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import Combine
import Foundation


struct ProfilePhotoSelectorView: View {
    @EnvironmentObject var service: SessionServiceImpl
    @Environment(\.presentationMode) var presentationMode
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    var body: some View {
        VStack {
            Text("Add a profile photo")
                .font(.system(size: 30))
            
            
            Button{
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: 180, height: 180)
                        .foregroundColor(Color(.systemGray))
                        .clipShape(Circle())
                        .padding(.top, 150)
                }
                else{
                    Image(systemName: "photo.circle")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .foregroundColor(Color(.systemGray))
                        .clipShape(Circle())
                        .padding(.top, 150)
                    
                }
                
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            Spacer()
            
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Cancel")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                }
                
                if let selectedImage = selectedImage {
                    Spacer()
                            .frame(width: 50)
                    Button{
                        uploadProfileImage(selectedImage)
                    }label: {
                        Text("Continue")
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray))
                            .foregroundColor(Color(.white))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
    func loadImage(){
        guard let  selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
    func uploadProfileImage(_ image: UIImage){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
        let ref = Database.database().reference().child("users").child(uid)

        ImageUploader.uploadImage(image: image){ profileImageUrl in
            let values = ["profileImageUrl" : profileImageUrl]
            ref.setValue(values)
        }
    }
        
}


    
struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
