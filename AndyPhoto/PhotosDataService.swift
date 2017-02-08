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
    var randomPhoto: Photo?

    func downloadPhotos(with sortType: SortType = .latest, completed: @escaping DownloadComplete) {
        let urlString = Constants.GET_GLOBAL_PHOTOS + "&order_by=\(sortType.nameFor())"
        guard let url = URL(string: urlString) else { return }

        request(url).responseJSON { (responce) in
            if let photosArray = responce.result.value as? [[String: Any]] {
                for photo in photosArray {
                    guard let photoToAdd = self.parsePhotoWith(inputDict: photo) else { return }

                    if let userInfo = photo["user"] as? [String: Any] {
                        photoToAdd.user = self.parseUserWith(inputDict: userInfo)
                    }

                    self.photos.append(photoToAdd)
                }
            }

            completed()
        }
    }

    func getRandomPhoto(completed: @escaping DownloadComplete) {
        guard let url = URL(string: Constants.GET_RANDOM_PHOTO) else { return }

        request(url).responseJSON { (response) in
            if let photoDict = response.result.value as? [String: Any] {
                let photoToAdd = self.parsePhotoWith(inputDict: photoDict)
                photoToAdd?.isRandom = true

                if let userInfo = photoDict["user"] as? [String: Any] {
                    photoToAdd?.user = self.parseUserWith(inputDict: userInfo)
                }

                self.randomPhoto = photoToAdd
            }

            completed()
        }
    }

    func likePhotoWith(id: String, completed: @escaping DownloadComplete) {
        let urlString = Constants.UNSPLASH_BASE_URL + "/photos/\(id)/like"
        guard let url = URL(string: urlString), let accessToken = AuthManager.sharedInstance.accessToken else { return }
        var header = HTTPHeaders()
        header["Authorization"] = "Bearer \(accessToken)"

        request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { (response) in

            if response.response?.statusCode == 201 {
                completed()
            }
        }
    }

    func unlikePhotoWith(id: String, completed: @escaping DownloadComplete) {
        let urlString = Constants.UNSPLASH_BASE_URL + "/photos/\(id)/like"
        guard let url = URL(string: urlString), let accessToken = AuthManager.sharedInstance.accessToken else { return }
        var header = HTTPHeaders()
        header["Authorization"] = "Bearer \(accessToken)"

        request(url, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("you deleted your like")
                completed()
            }
        }
    }

    private func parsePhotoWith(inputDict: [String: Any]) -> Photo? {
        var photoLikes = 0
        var photoDate = ""
        var photoUrl = ""
        var photoId = ""
        var isLiked = false

        if let likes = inputDict["likes"] as? Int,
            let date = inputDict["created_at"] as? String,
            let id = inputDict["id"] as? String,
            let liked = inputDict["liked_by_user"] as? Bool {
            photoLikes = likes
            photoDate = date
            photoId = id
            isLiked = liked
        }

        if let urlsBox = inputDict["urls"] as? [String: Any] {
            if let url = urlsBox["small"] as? String {
                photoUrl = url
            }
        }

        let photo = Photo(likes: photoLikes, creationDate: photoDate, photoUrl: photoUrl, photoId: photoId, isLiked: isLiked)

        return photo
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
