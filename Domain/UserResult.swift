//
//  UserResult.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import Foundation
import UIKit

struct UserResult: Hashable {
    var image: UIImage
    var name: String
    var username: String
    var friendshipRelation: FriendshipRelation
    
    init(image: UIImage = UIImage(),
         name: String = "",
         username: String = "",
         friendshipRelation: FriendshipRelation = .notFriends) {
        
        self.image = image
        self.name = name
        self.username = username
        self.friendshipRelation = friendshipRelation
    }
}
