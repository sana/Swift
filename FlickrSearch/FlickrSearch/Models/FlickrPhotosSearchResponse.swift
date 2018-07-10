//
//  FlickrPhotosSearchResponse.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/12/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct FlickrPhotosSearchResponse {
    let searchText: String
    let photoResponses: [FlickrPhotoResponse]
}

extension FlickrPhotosSearchResponse {
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
            photoResponses = photoArray.compactMap { photoJSON -> FlickrPhotoResponse? in
                return FlickrPhotoResponse(dictionary: photoJSON as? [String : Any])
            }
            self.searchText = searchText
        } catch {
            return nil
        }
    }
}

extension FlickrPhotosSearchResponse: FlickrResponseModel {
    func title() -> String {
        return searchText
    }

    func photos() -> [FlickrPhotoResponse] {
        return photoResponses
    }
}
