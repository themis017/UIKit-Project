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
    
    public static var followingsResults: [UserResult] = [
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 1", username: "following_1", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 2", username: "following_2", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 3", username: "following_3", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 4", username: "following_4", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 5", username: "following_5", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 6", username: "following_6", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 7", username: "following_7", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 8", username: "following_8", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 9", username: "following_9", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 10", username: "following_10", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 11", username: "following_11", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 12", username: "following_12", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 13", username: "following_13", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 14", username: "following_14", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 15", username: "following_15", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 16", username: "following_16", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 17", username: "following_17", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 18", username: "following_18", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 19", username: "following_19", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Following name 20", username: "following_20", friendshipRelation: .pending)
    ]
    
    public static var followersResults: [UserResult] = [
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 1", username: "follower_1", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 2", username: "follower_2", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 3", username: "follower_3", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 4", username: "follower_4", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 5", username: "follower_5", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 6", username: "follower_6", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 7", username: "follower_7", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 8", username: "follower_8", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 9", username: "follower_9", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 10", username: "follower_10", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 11", username: "follower_11", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 12", username: "follower_12", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 13", username: "follower_13", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 14", username: "follower_14", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 15", username: "follower_15", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 16", username: "follower_16", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 17", username: "follower_17", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 18", username: "follower_18", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 19", username: "follower_19", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Follower name 20", username: "follower_20", friendshipRelation: .pending)
    ]
}
