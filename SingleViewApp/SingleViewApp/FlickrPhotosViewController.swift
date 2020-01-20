//
//  FlickrPhotosViewController.swift
//  SingleViewApp
//
//  Created by Laurentiu Dascalu on 6/11/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import UIKit

final class FlickrPhotosViewController: UICollectionViewController {
    // MARK: - Properties
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 3

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        searchController.searchBar.searchBarStyle = .minimal
        collectionView.addSubview(searchController.searchBar)
        definesPresentationContext = true
        super.viewDidLoad()
    }

}

// MARK: - UICollectionViewDataSource
extension FlickrPhotosViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    //3
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {

    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension FlickrPhotosViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let userText = searchController.searchBar.text else {
            return
        }
        print(userText)
    }
}
