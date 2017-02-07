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
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?

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
        PhotosDataService.instance.downloadPhotos {
            self.activityIndicatorView?.stopAnimating()
            self.photos = PhotosDataService.instance.photos
        }
    }

    private func setupDicesNavigationButton() {
        let dicesButton = UIButton(type: .custom)
        dicesButton.setImage(#imageLiteral(resourceName: "Dices"), for: .normal)
        dicesButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        dicesButton.addTarget(self, action: #selector(PhotosViewController.handleRandomizeTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dicesButton)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoDetail" {
            let photoDetailViewController = segue.destination as? PhotoDetailViewController
            let photo = sender as? Photo
            photoDetailViewController?.photo = photo
        }
    }
}

//MARK: - Actions and handlers
extension PhotosViewController {
    func handleRandomizeTap() {

    }

    @IBAction func sortTypeValueChanged(_ sender: UISegmentedControl) {
        let sortType = SortType(rawValue: sender.selectedSegmentIndex)
        PhotosDataService.instance.photos.removeAll()
        PhotosDataService.instance.downloadPhotos(with: sortType ?? .latest) {
            self.photos = PhotosDataService.instance.photos
        }
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

        //TODO: - implement trick to see likes normally
        let photo = photos[indexPath.item]
        cell.configureCellWith(photo: photo)

        return cell
    }

    //MARK: delegate 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - should implement segue here
        let photo = photos[indexPath.item]
        performSegue(withIdentifier: "showPhotoDetail", sender: photo)
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
