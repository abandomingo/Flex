//
//  FeedView.swift
//  Flex362
//
//  Created by Aban Domingo on 4/19/23.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewPostView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.posts) { post in
                        PostRowView(post: post)
                            .padding()
                    }
                }
            }
            
            Button {
                showNewPostView.toggle()
            } label: {
                Image(systemName:"plus.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width:50, height: 50)
                    .padding()
                    .foregroundColor(.gray)
            }
            .padding()
            .fullScreenCover(isPresented: $showNewPostView) {
                NewPostView()
            }
        }

    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
