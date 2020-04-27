//
//  FlickrPhotosSearchResponseModel.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/12/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct FlickrPhotosSearchResponseModel {
    let searchText: String
    let photoResponses: [FlickrPhotoResponseModel]
}

extension FlickrPhotosSearchResponseModel {
    init?(data: Data?, searchText: String) {
        guard let data = data else {
            return nil
        }

        do {
            guard
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                (result["stat"] as? String) == "ok"
            else {
                return nil
            }

            guard
                let photosDictionary = result["photos"] as? [String: Any],
                let photoArray = photosDictionary["photo"] as? [Any]
            else {
                return nil
            }

            photoResponses = photoArray.compactMap { photoJSON -> FlickrPhotoResponseModel? in
                return FlickrPhotoResponseModel(dictionary: photoJSON as? [String : Any])
            }

            self.searchText = searchText
        } catch {
            return nil
        }
    }
}
