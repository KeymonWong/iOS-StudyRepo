//
//  OKFlickrPhotoViewController.swift
//  FlickrSearchPhoto
//
//  Created by keymon on 2019/5/8.
//  Copyright © 2019 ok. All rights reserved.
//

import UIKit

private let reuseIdentifier = "OKFlickrPhotoCell"
private let sectionInset = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

private let searches: [OKFlickrSearchResults] = []
private let flickr = OKFlickr()

private let itemsPerRow: CGFloat = 3.0

class OKFlickrPhotoViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OKFlickrPhotoCell
        
        let flickrPhoto = photo(for: indexPath)
        cell.backgroundColor = .white
        
        cell.photoImgV.image = flickrPhoto.thumbnail
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


// MARK: - private
private extension OKFlickrPhotoViewController {
    func photo(for indexPath: IndexPath) -> OKFlickrPhoto {
        return searches[indexPath.section].searchResults?[indexPath.row]
    }
}

// MARK: - UITextFieldDelegate
extension OKFlickrPhotoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = textField.bounds
        textField.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        flickr.searchFlickr(for: textField.text) {
            
        }
        
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OKFlickrPhotoViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // 2
        let paddingSpace = sectionInset.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return sectionInset
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return sectionInset.left
    }
}
