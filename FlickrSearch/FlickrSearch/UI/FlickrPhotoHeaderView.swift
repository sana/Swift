//
//  FlickrPhotoHeaderView.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/10/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import UIKit

class FlickrPhotoHeaderView: UICollectionReusableView {
    private var textLabel: UILabel

    enum Constants {
        public static let height: CGFloat = 60
    }

    override init(frame: CGRect) {
        textLabel = UILabel()
        textLabel.font = FlickrPhotosViewController.Constants.headerTitleFont

        super.init(frame: frame)
        addSubview(textLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leftAnchor.constraint(
            equalTo: leftAnchor,
            constant: FlickrPhotosViewController.Constants.sectionInsets.left
        ).isActive = true
        textLabel.rightAnchor.constraint(
            equalTo: rightAnchor,
            constant: FlickrPhotosViewController.Constants.sectionInsets.right
        ).isActive = true
        textLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: FlickrPhotosViewController.Constants.sectionInsets.top
        ).isActive = true
        textLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: FlickrPhotosViewController.Constants.sectionInsets.bottom
        ).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        didSet {
            textLabel.text = text
            setNeedsLayout()
        }
    }
}
