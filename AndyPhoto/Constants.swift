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

    static let APP_ID = "920b38b7aa7791bd1e310a2f3ecaa460f0021dac686c905d415bff078501a340"

    static let REDIRECT_URI = "urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob"

    static let APP_SECRET = "c3e7b4077029eec5f9cb335b2776f05bfe3f46727d9f3725149eafa3048ad560"

    static let GET_GLOBAL_PHOTOS = UNSPLASH_BASE_URL + "photos/?client_id=" + APP_ID + "&per_page=15"

    static let defaultInset: CGFloat = 2.5
}

typealias DownloadComplete = () -> ()
