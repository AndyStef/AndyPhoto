//
//  User.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class User {
    //TODO: - i should make some of this optional
    var username: String
//    var name: String
    var bio: String
    var location: String
    var totalLikes: Int
    var totalPhotos: Int
    var profileImageUrl: String
    var profileUmage: UIImage?

    init(username: String, bio: String, location: String, totalLikes: Int, totalPhotos: Int, profileImageUrl: String) {
        self.username = username
        self.bio = bio
        self.location = location
        self.totalLikes = totalLikes
        self.totalPhotos = totalPhotos
        self.profileImageUrl = profileImageUrl
    }
}
