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

    @IBAction func testAction(_ sender: UIBarButtonItem) {
        guard let url = URL(string: Constants.GET_GLOBAL_PHOTOS) else { return }
        request(url).responseJSON { (responce) in
            print(responce)
        }
    }
}

//MARK: - Actions and handlers
extension PhotosViewController {
    func handleRandomizeTap() {
        print("test")
    }
}

//MARK: - UICollectionView delegate, data source
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) //else {
        //    return UICollectionViewCell()
      //  }

        cell.backgroundColor = .red

        return cell
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
