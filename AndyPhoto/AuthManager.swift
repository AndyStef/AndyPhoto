//
//  AuthManager.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation
import Alamofire

class AuthManager {

    func authURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "unsplash.com"
        components.path = "/oauth/authorize"

        components.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.APP_ID),
            URLQueryItem(name: "redirect_uri", value: self.redirectURL.absoluteString),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "public+write_likes")
        ]

        return components.url
    }

    func accessTokenUrl(code: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "unsplash.com"
        components.path = "/oauth/token"

        components.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.APP_ID),
            URLQueryItem(name: "client_secret", value: Constants.APP_SECRET),
            URLQueryItem(name: "redirect_uri", value: self.redirectURL.absoluteString),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code)
        ]

        return components.url
    }

    func retrieveAccessTokenFrom(url: URL, completionHandler: @escaping () -> ()) {
        request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if let result = response.result.value as? [String: Any] {
                if let accessToken = result["access_token"] as? String {
                    self.accessToken = accessToken
                    completionHandler()
                }
            }
        }
    }

    static let sharedInstance = AuthManager(appId: Constants.APP_ID, secret: Constants.APP_SECRET)

    private let appId: String
    private let secret: String
    private let redirectURL: URL
    var accessToken: String? = nil

    init(appId: String, secret: String) {
        self.appId = appId
        self.secret = secret
        self.redirectURL = URL(string: Constants.REDIRECT_URL)!
    }

}
