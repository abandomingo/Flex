//
//  PostRowView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI
import Kingfisher

struct PostRowView: View {
    @ObservedObject var viewModel: PostRowViewModel
    
    init(post: Post){
        self.viewModel = PostRowViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if let user = viewModel.post.user {
                HStack(alignment: .top, spacing: 12){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        
                    VStack(alignment: .leading, spacing: 4){
                        HStack{
                            Text(user.fullname)
                                .font(.subheadline)
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            //get this to convert time stamp into string
//                            Text("\(viewModel.post.timestamp)")
//                                .foregroundColor(.gray)
//                                .font(.caption)
                        }
                        Text(viewModel.post.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        // if there is a post
                        if let postUrl = viewModel.post.postUrl{
                            KFImage(postUrl)
                                .resizable()
                                .scaledToFill()
                        }
    
                    }
                }
            }
            HStack{
                Button{
                    viewModel.post.didLike ?? false ?
                    viewModel.unlikePost() :
                    viewModel.likePost()
                } label:{
                    Image(systemName: viewModel.post.didLike ?? false ? "heart.fill": "heart")
                        .foregroundColor(viewModel.post.didLike ?? false ? .red : .gray)
                }
                
                Spacer()
                    .frame(width:50)

                Button{
                    //add comment
                } label:{
                    Image(systemName: "bubble.left")
                        .foregroundColor(.gray)
                }
                .padding(5)
                

            }
            .padding()
            Divider()
        }
        
    }
}

//struct PostRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRowView()
//    }
//}
