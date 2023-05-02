//
//  User.swift
//  Flex362
//
//  Created by Aban Domingo on 4/22/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
}
