//
//  UserDetailViewController.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet private weak var profileImageView: UIImageView?
    @IBOutlet private weak var usernameLabel: UILabel?
    @IBOutlet private weak var likesCountLabel: UILabel?
    @IBOutlet private weak var photosCountLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var userBioTextView: UITextView?

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeImageView()
        if let actualUser = user {
            setupUIWith(user: actualUser)
        }
    }

    private func setupUIWith(user: User) {
        profileImageView?.image = user.profileUmage
        usernameLabel?.text = user.username
        likesCountLabel?.text = String(user.totalLikes)
        photosCountLabel?.text = String(user.totalPhotos)
        locationLabel?.text = String(user.location)
        userBioTextView?.text = user.bio
    }

    private func customizeImageView() {
        profileImageView?.layer.cornerRadius = 75
        profileImageView?.layer.masksToBounds = true
    }
}
