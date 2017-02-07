//
//  PhotosDataService.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation
import Alamofire

enum SortType: Int {
    case latest, oldest, popular

    func nameFor() -> String {
        switch self {
        case .latest:
            return "latest"
        case .oldest:
            return "oldest"
        case .popular:
            return "popular"
        }
    }
}

class PhotosDataService {
    static let instance = PhotosDataService()

    var photos = [Photo]()

    func downloadPhotos(with sortType: SortType = .latest, completed: @escaping DownloadComplete) {
        let urlString = Constants.GET_GLOBAL_PHOTOS + "&order_by=\(sortType.nameFor())"
        guard let url = URL(string: urlString) else { return }
        var photoLikes = 0
        var photoDate = ""
        var photoUrl = ""
        
        request(url).responseJSON { (responce) in
            if let photosArray = responce.result.value as? [[String: Any]] {
                for photo in photosArray {
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

                    let photoToAdd = Photo(likes: photoLikes, creationDate: photoDate, photoUrl: photoUrl)
                    if let userInfo = photo["user"] as? [String: Any] {
                        photoToAdd.user = self.parseUserWith(inputDict: userInfo)
                    }

                    self.photos.append(photoToAdd)
                }
            }

            completed()
        }
    }

    private func parseUserWith(inputDict: [String: Any]) -> User? {
        //MARK: - this can be prevented with optionals
        var userUsername = ""
        var userBio = ""
        var userLocation = ""
        var userTotalLikes = 0
        var userTotalPhotos = 0
        var userProfileImageUrl = ""

        if let username = inputDict["username"] as? String,
            let bio = inputDict["bio"] as? String ,
            let location = inputDict["location"] as? String,
            let totalLikes = inputDict["total_likes"] as? Int,
            let totalPhotos = inputDict["total_photos"] as? Int {
            userUsername = username
            userBio = bio
            userLocation = location
            userTotalLikes = totalLikes
            userTotalPhotos = totalPhotos
        }

        if let imageProfileUrlBox = inputDict["profile_image"] as? [String: Any] {
            if let profileImageUrl = imageProfileUrlBox["medium"] as? String {
                userProfileImageUrl = profileImageUrl
            }
        }

        return User(username: userUsername, bio: userBio, location: userLocation, totalLikes: userTotalLikes, totalPhotos: userTotalPhotos, profileImageUrl: userProfileImageUrl)
    }
}
