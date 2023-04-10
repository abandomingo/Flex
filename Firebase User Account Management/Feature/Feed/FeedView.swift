//
//  FeedView.swift
//  Firebase User Account Management
//
//  Created by Aban Domingo on 3/8/23.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewPostView = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(0 ... 20, id: \.self) { _ in
                        PostComponent()
                        
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
