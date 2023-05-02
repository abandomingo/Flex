//
//  UploadPostViewModel.swift
//  Flex362
//
//  Created by Aban Domingo on 4/23/23.
//

import Foundation

class UploadPostViewModel: ObservableObject {
    @Published var didUploadPost = false
    
    let service = PostService()
    
    func uploadPost(withCaption caption: String, withPostUrl postUrl: String) {
        service.uploadPost(caption: caption, postUrl: postUrl) { success in
            if success{
                self.didUploadPost = true
            }else {
                //
            }
        }
    }
}
