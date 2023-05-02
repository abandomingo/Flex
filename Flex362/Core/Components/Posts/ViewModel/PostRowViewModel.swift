//
//  PostRowViewModel.swift
//  Flex362
//
//  Created by Aban Domingo on 4/23/23.
//

import Foundation

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    private let service = PostService()
    
    
    init(post: Post){
        self.post = post
        checkIfUserLikedPost()  
    }
    
    func likePost(){
        service.likePost(post){
            self.post.didLike = true
            
        }
    }
    func unlikePost(){
        service.unlikePost(post){
            self.post.didLike = false
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
}
