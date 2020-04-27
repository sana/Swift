//
//  FlickrResponseViewModel.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/12/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol FlickrResponseViewModel {
    func title() -> String
    func photos() -> [FlickrPhotoResponseViewModel]
}

extension FlickrGetRecentResponseModel : FlickrResponseViewModel {
    func title() -> String {
        return queryTimestamp
    }

    func photos() -> [FlickrPhotoResponseViewModel] {
        return photoResponses
    }
}

extension FlickrPhotosSearchResponseModel: FlickrResponseViewModel {
    func title() -> String {
        return searchText
    }

    func photos() -> [FlickrPhotoResponseViewModel] {
        return photoResponses
    }
}
