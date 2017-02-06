//
//  PhotosDataService.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation
import Alamofire

class PhotosDataService {
    static let instance = PhotosDataService()

    var photos = [Photo]()

    func downloadPhotos(completed: @escaping DownloadComplete) {
        guard let url = URL(string: Constants.GET_GLOBAL_PHOTOS) else { return }
        //var likes: Int?
        var photoLikes = 0
        var photoDate = ""
        var photoUrl = ""
        
        request(url).responseJSON { (responce) in
            //print(responce)
            if let photosArray = responce.result.value as? [[String: Any]] {
                for photo in photosArray {
                    //we are in array of photos so we can put them in objects right here
                    if let likes = photo["likes"] as? Int,
                        let date = photo["created_at"] as? String {
                        photoLikes = likes
                        photoDate = date
                    }

                    if let urlsBox = photo["urls"] as? [String: Any] {
                        if let url = urlsBox["small"] as? String {
                            photoUrl = url
                        }
                    }

                    //TODO: - parse user as well
                    let photo = Photo(likes: photoLikes, creationDate: photoDate, photoUrl: photoUrl)
                    self.photos.append(photo)
                }
            }
            for photo in self.photos {
                print(photo.photoUrl)
            }

            //TODO: parse JSON and put data into objects
            completed()
        }
    }
}
