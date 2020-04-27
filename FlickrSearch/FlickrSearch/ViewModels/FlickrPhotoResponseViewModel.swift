//
//  FlickrPhotoResponseViewModel.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 4/26/20.
//  Copyright © 2020 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import CoreGraphics

protocol FlickrPhotoResponseViewModel {
    var title: String { get }
    var imageURL: String? { get }
}

extension FlickrPhotoResponseModel : FlickrPhotoResponseViewModel {
    var imageURL: String? {
        return "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret)_m.jpg"
    }
}
