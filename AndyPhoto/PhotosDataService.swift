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

//    var photos: [Photo]
    func downloadPhotos(completed: @escaping DownloadComplete) {
        guard let url = URL(string: Constants.GET_GLOBAL_PHOTOS) else { return }
        request(url).responseJSON { (responce) in
            print(responce)
            //TODO: parse JSON and put data into objects
            completed()
        }
    }
}
