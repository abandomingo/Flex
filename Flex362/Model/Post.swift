//
//  Post.swift
//  Flex362
//
//  Created by Aban Domingo on 4/23/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var postUrl: URL?
    
    var user: User?
    var didLike: Bool? = false
}
