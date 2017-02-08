//
//  PhotoCollectionViewCell.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var likesLabel: UILabel?
    @IBOutlet private weak var imageView: UIImageView?

    func configureCellWith(photo: Photo) {
        likesLabel?.text = String(photo.likes)

        //TODO: - Refactor this maybe i dont want to load images here
        if let photoImage = photo.photoImage {
            imageView?.image = photoImage
        } else {
            photo.downloadPhotoImage {
                self.imageView?.image = photo.photoImage
            }
        }
    }
}
