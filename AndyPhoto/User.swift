//
//  User.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit
import Alamofire

class User {
    //TODO: - i should make some of this optional
    var username: String
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

    func downloadProfileImage(completed: @escaping DownloadComplete) {
        request(self.profileImageUrl).responseData { (responce) in
            if let data = responce.result.value {
                if let image = UIImage(data: data) {
                    self.profileUmage = image
                }
            }

            completed()
        }
    }
}
