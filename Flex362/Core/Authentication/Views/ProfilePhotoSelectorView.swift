//
//  ProfilePhotoSelectorView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/22/23.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        ZStack{
                Image("upload")
                    .resizable()
                
            VStack{
                Text("Upload a Profile Picture")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 150)
                
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    //postImage
                    if let profileImage = profileImage{
                        profileImage
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    }else{
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color(.white))
                    
                        }
                    }
                
                if let selectedImage = selectedImage{
                    Button{
                        //change this to upload Post
                        viewModel.uploadProfileImage(selectedImage)
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(Color(.white))
                            .frame(width: 340, height: 50)
                            .background(Color(.darkGray))
                            .cornerRadius(100)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
            }
            
            }
            .ignoresSafeArea()
        }
        func loadImage() {
            guard let selectedImage = selectedImage else {return}
            profileImage = Image(uiImage: selectedImage)
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
