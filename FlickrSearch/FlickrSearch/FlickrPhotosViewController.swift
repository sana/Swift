//
//  FlickrPhotosViewController.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import UIKit

final class FlickrPhotosViewController: UICollectionViewController {

    // MARK: - Properties
    fileprivate let reuseIdentifier = "FlickrCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 12, left: 12.5, bottom: 12, right: 12)
    fileprivate let flickrAPI = FlickrAPI()
    fileprivate var flickrResponses = [FlickrResponseModel]()
    fileprivate let itemsPerRow: CGFloat = 4

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickrPhotosViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.refreshControl = refreshControl
        self.collectionView?.alwaysBounceVertical = true
    }
}

extension FlickrPhotosViewController {
    /* Pull to refresh delegate */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        flickrAPI.getRecent { [weak self] result, error in
            DispatchQueue.main.async {
                guard
                    error == nil,
                    let result = result
                else {
                    return
                }
                self?.flickrResponses.insert(result, at: 0)
                self?.collectionView?.reloadData()
            }
        }
    }
}

extension FlickrPhotosViewController : UITextFieldDelegate {

    @IBAction func cancelButtonCallback(sender: UIButton) {
        searchTextField.text = "Search Flickr"
        searchTextField.resignFirstResponder()
        self.cancelButton.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
        self.cancelButton.isHidden = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = textField.text else {
            return false
        }

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()

        textField.text = nil
        textField.resignFirstResponder()

        flickrAPI.photosSearch(forSearchText: searchText) { [weak self] result, error in
            DispatchQueue.main.async {
                guard
                    error == nil,
                    let result = result
                else {
                    return
                }
                self?.flickrResponses.insert(result, at: 0)
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self?.searchTextField.text = "Search Flickr"
                self?.cancelButton.isHidden = true
                self?.collectionView?.reloadData()
            }
        }

        return true
    }
}

extension FlickrPhotosViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return flickrResponses.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrResponses[section].photos().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FlickrPhotoCell else {
            return UICollectionViewCell()
        }

        let photoResult = flickrResponses[indexPath.section]
        let photoResponse = photoResult.photos()[indexPath.row]

        cell.viewModel = photoResponse

        flickrAPI.fetch(imageAtURL: photoResponse.url()) {
            result, error in

            if photoResponse == cell.viewModel {
                DispatchQueue.main.async {
                    cell.imageView.image = result
                }
            }
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FlickrPhotoHeaderView", for: indexPath) as? FlickrPhotoHeaderView else {
            return UICollectionReusableView()
        }
        headerView.textLabel.text = flickrResponses[indexPath.section].title()
        return headerView
    }
}

extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
