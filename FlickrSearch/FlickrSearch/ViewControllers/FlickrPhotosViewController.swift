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

    struct Constants {
        public static let sectionInsets = UIEdgeInsets(top: 12, left: 12.5, bottom: 12, right: 12)
        fileprivate static let cellReuseIdentifier = "FlickrCell"
        fileprivate static let headerViewReuseIdentifier = "FlickrPhotoHeaderView"
        public static let headerTitleFont = UIFont.systemFont(ofSize: 24.0)

        fileprivate static let titleFont = UIFont.systemFont(ofSize: 20.0)
        fileprivate static let titleToImagePadding: CGFloat = 12
    }

    // MARK: - Properties
    fileprivate let flickrAPI = FlickrAPI()
    fileprivate var flickrResponses = [FlickrResponseViewModel]()
    fileprivate let itemsPerRow: CGFloat = 1

    weak var cancelButton: UIButton!
    weak var searchTextField: UITextField!

    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickrPhotosViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor.white
        collectionView?.refreshControl = refreshControl
        collectionView?.alwaysBounceVertical = true

        collectionView?.register(
            FlickrPhotoHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.headerViewReuseIdentifier
        )

        collectionView?.register(
            FlickrPhotoCell.self,
            forCellWithReuseIdentifier: Constants.cellReuseIdentifier
        )
    }
}

extension FlickrPhotosViewController {
    /* Pull to refresh delegate */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        flickrAPI.getRecent { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard
                    case let .success(model) = result,
                    let self = self
                else {
                    return
                }
                refreshControl.endRefreshing()
                self.flickrResponses.insert(model, at: 0)
                self.collectionView.insertSections(IndexSet([0]))
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension FlickrPhotosViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return flickrResponses.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return flickrResponses[section].photos().count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.cellReuseIdentifier,
                for: indexPath
            ) as? FlickrPhotoCell
        else {
            return UICollectionViewCell()
        }

        let photoResult = flickrResponses[indexPath.section]
        let photoResponse = photoResult.photos()[indexPath.row]

        cell.viewModel = photoResponse

        photoResponse.imageURL.map {
            flickrAPI.fetch(imageAtURL: $0) { result in
                guard case let .success(image) = result else {
                    return
                }
                DispatchQueue.main.async {
                    cell.update(withPhotoResponse: photoResponse, image: image)
                }
            }
        }

        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: Constants.headerViewReuseIdentifier,
                for: indexPath
            ) as? FlickrPhotoHeaderView
        else {
            return UICollectionReusableView()
        }
        headerView.text = flickrResponses[indexPath.section].title()
        return headerView
    }
}

extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: FlickrPhotoHeaderView.Constants.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        let photoResult = flickrResponses[indexPath.section]
        let photoResponse = photoResult.photos()[indexPath.row]

        let titleHeight = photoResponse.title.heightWithConstrainedWidth(width: widthPerItem, font: Constants.titleFont)

        return CGSize(
            width: widthPerItem,
            height: titleHeight + Constants.titleToImagePadding + FlickrPhotoCell.Constants.imageHeight
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return Constants.sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.sectionInsets.left
    }

}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return boundingBox.height
    }
}


extension FlickrPhotosViewController : UITextFieldDelegate {

    func cancelButtonCallback(sender: UIButton) {
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

        let activityIndicator = UIActivityIndicatorView(style: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()

        textField.text = nil
        textField.resignFirstResponder()

        flickrAPI.photosSearch(forSearchText: searchText) { [weak self] result in
            guard case let .success(model) = result else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                self.flickrResponses.insert(model, at: 0)

                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()

                self.searchTextField.text = "Search Flickr"
                self.cancelButton.isHidden = true

                self.collectionView.insertSections(IndexSet([0]))
            }
        }

        return true
    }
}
