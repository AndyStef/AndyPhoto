//
//  Photo.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit
import Alamofire

class Photo {
    //TODO: - i should make some of this optional
    var creationDate: String
    var likes: Int
    var photoUrl: String
    var photoImage: UIImage?
    var user: User?
    var isRandom: Bool?

    init(likes: Int, creationDate: String, photoUrl: String) {
        self.likes = likes
        self.creationDate = creationDate
        self.photoUrl = photoUrl
    }

    func downloadPhotoImage(completed: @escaping DownloadComplete) {
        request(self.photoUrl).responseData { (responce) in
            if let data = responce.result.value {
                if let image = UIImage(data: data) {
                    self.photoImage = image
                }
            }

            completed()
        }
    }
}
