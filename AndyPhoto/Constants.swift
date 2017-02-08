//
//  Constants.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

struct Constants {

    static let UNSPLASH_BASE_URL = "https://api.unsplash.com/"

    static let APP_ID = "a318deaa9ea6f0f7fd14e1e4d5e01aeb93793ff3a7b008d15bbe0eaa51e99656"

    static let REDIRECT_URI = "urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob"

    static let REDIRECT_URL = "urn:ietf:wg:oauth:2.0:oob"

    static let APP_SECRET = "21bfbc1fa1c9baab3ae1a39e49caf43453e6c2905bca70449149b0de23b7be27"

    static let GET_GLOBAL_PHOTOS = UNSPLASH_BASE_URL + "photos/?client_id=" + APP_ID + "&per_page=15"

    static let GET_RANDOM_PHOTO = UNSPLASH_BASE_URL + "photos/random/?client_id=" + APP_ID

    static let defaultInset: CGFloat = 2.5
}

typealias DownloadComplete = () -> ()
