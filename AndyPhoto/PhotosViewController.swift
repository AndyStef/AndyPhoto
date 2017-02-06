//
//  ViewController.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit
import Alamofire

class PhotosViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView?
    fileprivate var photos = [Photo]() {
        didSet {
            collectionView?.reloadData()
        }
    }

    fileprivate struct CellId {
        static let photoCellId = "photoCellId"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.delegate = self
        collectionView?.dataSource = self
        setupDicesNavigationButton()
    }

    private func setupDicesNavigationButton() {
        let dicesButton = UIButton(type: .custom)
        dicesButton.setImage(#imageLiteral(resourceName: "Dices"), for: .normal)
        dicesButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        dicesButton.addTarget(self, action: #selector(PhotosViewController.handleRandomizeTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dicesButton)
    }
}

//MARK: - Actions and handlers
extension PhotosViewController {
    func handleRandomizeTap() {
        PhotosDataService.instance.downloadPhotos {
            self.photos = PhotosDataService.instance.photos
            print("Succes")
        }

        print("test")
    }
}

//MARK: - UICollectionView delegate, data source
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.photoCellId, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        let photo = photos[indexPath.item]
        cell.configureCellWith(photo: photo)

        return cell
    }

    //MARK: delegate 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - should implement segue here
        let user = photos[indexPath.item].user
        print(user?.location)
    }

    //MARK: Flow layout sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3 - 4
        
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.defaultInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.defaultInset
    }
}
