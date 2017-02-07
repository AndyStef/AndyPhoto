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
    @IBOutlet private weak var randomButton: UIButton?

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

    fileprivate func setupUIWith(photo: Photo) {
        if photo.photoImage == nil {
            photo.downloadPhotoImage(completed: { 
                self.photoImageView?.image = photo.photoImage
            })
        }

        if photo.isRandom ?? false {
            randomButton?.isHidden = false
        }

        likeButton?.setImage(photo.isLikedByUser ? #imageLiteral(resourceName: "liked_icon"): #imageLiteral(resourceName: "like_outline"), for: .normal)
        usernameLabel?.text = photo.user?.username
        photoImageView?.image = photo.photoImage
        likesNumberLabel?.text = String(photo.likes) + " likes"
        photo.user?.downloadProfileImage {
            self.userProfileImageView?.image = photo.user?.profileUmage
        }
    }

    private func customizeProfileImageView() {
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
        if AuthManager.sharedInstance.accessToken != nil {
            if photo?.isLikedByUser ?? false {
                PhotosDataService.instance.unlikePhotoWith(id: photo?.photoId ?? "", completed: { 
                    self.likeButton?.setImage(#imageLiteral(resourceName: "like_outline"), for: .normal)
                    self.photo?.isLikedByUser = false
                })
            } else {
                PhotosDataService.instance.likePhotoWith(id: photo?.photoId ?? "") {
                    self.photo?.isLikedByUser = true
                    self.likeButton?.setImage(#imageLiteral(resourceName: "liked_icon"), for: .normal)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "You cannot like photos when you are not authorized, please go to starter page and sign in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func handleUserInfoTap() {
        performSegue(withIdentifier: "showUserDetail", sender: self)
    }

    @IBAction private func randomButtonPressed(_ sender: Any) {
        PhotosDataService.instance.getRandomPhoto {
            guard let randomPhoto = PhotosDataService.instance.randomPhoto else { return }
            self.photo = randomPhoto
            self.setupUIWith(photo: randomPhoto)
        }
    }
}
