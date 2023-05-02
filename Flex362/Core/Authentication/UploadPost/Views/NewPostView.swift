//
//  NewPostView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//


import SwiftUI
import Firebase
import FirebaseStorage
import Kingfisher

struct NewPostView: View {
     
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    @State private var postImage: Image?
    @State private var caption = ""
    @State private var postUrl = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel : AuthViewModel
    @ObservedObject var viewModel = UploadPostViewModel()
    
    
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
                .onAppear {
                    loadImage()
                }
                
                Spacer()
                
                Button{
                    guard let selectedImage = selectedImage else {return}
                    uploadImageToFirebase(image: selectedImage) { imageUrl in
                        if let postUrl = imageUrl {
                            viewModel.uploadPost(withCaption: caption, withPostUrl: postUrl)
                        } else {
                            print("Image Upload Failed")
                        }
                    }
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
                if let user = authViewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TextArea("What's happening", text: $caption)
                    .foregroundColor(.white)
            }
            .padding()
            
            Button {
                showImagePicker.toggle()
            } label: {
                //postImage
                if let postImage = postImage{
                    postImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }else{
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color(.white))
                
                    }
                }
        }
        .sheet(isPresented: $showImagePicker,
               onDismiss: loadImage){
            ImagePicker(selectedImage: $selectedImage)
        }
        .onReceive(viewModel.$didUploadPost) {success in
            if success{
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        postImage = Image(uiImage: selectedImage)
    }
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/post_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }

            ref.downloadURL { imageUrl, _ in
                        guard let imageUrl = imageUrl?.absoluteString else {
                            completion(nil)
                            return
                        }
                        
                        completion(imageUrl)
                    }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

