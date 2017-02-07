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
    @IBOutlet fileprivate weak var likeButton: UIButton?
    @IBOutlet private weak var likesNumberLabel: UILabel?
    @IBOutlet private weak var userInfoView: UIView?

    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeProfileImageView()
        addTapGestureForUserInfoView()
        if let actualPhoto = photo {
            setupUIWith(photo: actualPhoto)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetail" {
            let userDetailViewController = segue.destination as? UserDetailViewController
            userDetailViewController?.user = photo?.user
        }
    }

    private func setupUIWith(photo: Photo) {
        usernameLabel?.text = photo.user?.username
        photoImageView?.image = photo.photoImage
        likesNumberLabel?.text = String(photo.likes) + " likes"
        photo.user?.downloadProfileImage {
            self.userProfileImageView?.image = photo.user?.profileUmage
        }
    }

    private func customizeProfileImageView() {
        //TODO: - WTF?
        userProfileImageView?.layer.cornerRadius = 22
        userProfileImageView?.layer.masksToBounds = true
    }

    private func addTapGestureForUserInfoView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PhotoDetailViewController.handleUserInfoTap))
        usernameLabel?.addGestureRecognizer(tapGestureRecognizer)
        userProfileImageView?.addGestureRecognizer(tapGestureRecognizer)
        userInfoView?.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: - Actions and handlers 
extension PhotoDetailViewController {
    @IBAction private func likeButtonPressed(_ sender: UIButton) {
        //TODO: - implement like/unlike here
        if AuthManager.sharedInstance.accessToken != nil {
            print("You can like photos")
        } else {
            print("You can notttt like suck")
        }
        likeButton?.setImage(#imageLiteral(resourceName: "liked_icon"), for: .normal)
    }

    func handleUserInfoTap() {
        performSegue(withIdentifier: "showUserDetail", sender: self)
    }
}
