//
//  FlickrPhotoCell.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import UIKit

class FlickrPhotoCell : UICollectionViewCell {
    private let stackView: UIStackView
    private let imageView: UIImageView
    private let label: UILabel

    struct Constants {
        static let imageHeight: CGFloat = 72
    }

    var viewModel: FlickrPhotoResponseViewModel? {
        didSet {
            imageView.image = FlickrSharedResources.notFoundUIImage
            label.text = viewModel?.title
        }
    }

    override init(frame: CGRect) {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0

        label = UILabel()
        label.textAlignment = .left

        stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.alignment = .top
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewModel = nil
        super.init(frame: frame)

        autoresizesSubviews = true

        addSubview(stackView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        self.viewModel = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.stackView.frame = self.bounds
    }

    func update(withPhotoResponse photoResponse: FlickrPhotoResponseViewModel, image: UIImage?) {
        guard
            photoResponse.imageURL == viewModel?.imageURL
        else {
            // Cell has been since reused
            return
        }

        guard
            let originalImage = image ?? FlickrSharedResources.notFoundUIImage,
            originalImage.size.height > 0
        else {
            return
        }

        let newSize = CGSize(
            width: originalImage.size.width / originalImage.size.height * Constants.imageHeight,
            height: Constants.imageHeight
        )
        imageView.image = originalImage.scaleImage(toSize: newSize)
        setNeedsLayout()
    }
}
