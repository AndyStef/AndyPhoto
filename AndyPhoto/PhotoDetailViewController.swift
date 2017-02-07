//
//  PhotoDetailViewController.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet private weak var userProfileImageView: UIImageView?
    @IBOutlet private weak var usernameLabel: UILabel?
    @IBOutlet private weak var photoImageView: UIImageView?

    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let actualPhoto = photo {
            setupUIWith(photo: actualPhoto)
        }
    }

    private func setupUIWith(photo: Photo) {
        usernameLabel?.text = photo.user?.username
        photoImageView?.image = photo.photoImage
    }
}
