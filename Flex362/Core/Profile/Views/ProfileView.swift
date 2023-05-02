//
//  ProfileView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedFilter: PostFilterViewModel = .posts
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showLogoutView = false
    
    @Namespace var animation
    
    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            headerView
            
            userInfo

            filterBar
            
            postView
            
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: NSUUID().uuidString,
                              username: "Aban",
                              fullname: "Aban Domingo",
                              profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/flex-b525b.appspot.com/o/profile_image%2FB0EB24E8-A860-48D0-89DD-0636F39C84F6?alt=media&token=50442059-667b-442a-b891-6db9a5bf4fbd",
                               email: "aban@test.com"))
    }
}

extension ProfileView{
    
    var headerView: some View{
        ZStack{
            Color(.systemGray4)
                .ignoresSafeArea()
                .frame(height: 75)
            
            VStack{
                
                HStack{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "arrowshape.backward.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(.black))
                            
                    }
                    
                    Spacer()
                    
                    Button {
                        showLogoutView.toggle()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(.black))
                    }
                    .fullScreenCover(isPresented: $showLogoutView) {
                        LogoutView()
                    }
                    
                }
                .padding()
            
            }
            
        }
        .frame(height: 50)
    }
    
    var filterBar: some View{
        HStack{
            ForEach(PostFilterViewModel.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color(.systemGray) : Color(.systemGray))
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemGray))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture{
                    withAnimation(.easeOut){
                        self.selectedFilter = item
                    }
                }
            }
            
        }
        .overlay(Divider().offset(x:0, y:16))
    }
    
    var postView: some View{
        ScrollView{
            LazyVStack{
                ForEach(viewModel.posts(forFilter: self.selectedFilter)) {post in
                    PostRowView(post: post)
                        .padding()
                }
            }
        }
        
    }

    var editView: some View{
        HStack(){
            Button {
                //action here
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .frame(width: 100, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black , lineWidth: 0.75))
                    .foregroundColor(.black)
            }
        }
    }
    
    var userInfo: some View{
        VStack(alignment: .leading, spacing: 4){
            HStack{
                VStack(alignment: .leading){
                    Text(viewModel.user.fullname)
                        .font(.title3).bold()
                        .frame(height: 10)
                    Text("@\(viewModel.user.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                    .frame(width: 125)
                
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 75)
            }
            


            HStack(spacing: 10){
                HStack(){
                    Text("1")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    
                    Text("Followers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                HStack{
                    Text("1")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Following")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .font(.caption)
            .foregroundColor(.black)
            .padding(.vertical)
        }
        .padding(.horizontal)
        
    }
}



