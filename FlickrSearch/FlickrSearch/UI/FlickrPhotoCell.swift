//
//  FlickrPhotoCell.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import UIKit

class FlickrPhotoCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: FlickrPhotoResponse? {
        didSet {
            self.imageView.image = FlickrSharedResources.notFoundUIImage
        }
    }

    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = nil
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        self.viewModel = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }
}
