//
//  FlickrPhotoResponse.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct FlickrPhotoResponse {
    let farmID: String
    let serverID: String
    let photoID: String
    let secret: String
}

extension FlickrPhotoResponse {
    init?(dictionary: [String : Any]?) {
        guard
            let dictionary = dictionary,
            let farmID = dictionary["farm"] as? Int,
            let serverID = dictionary["server"] as? String,
            let photoID = dictionary["id"] as? String,
            let secret = dictionary["secret"] as? String
        else {
            return nil
        }
        self.farmID = String(farmID)
        self.serverID = serverID
        self.photoID = photoID
        self.secret = secret
    }
}

extension FlickrPhotoResponse : FetchableURLProtocol {
    func url() -> String {
        return "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret)_m.jpg"
    }
}

extension FlickrPhotoResponse : Equatable { }

func ==(lhs: FlickrPhotoResponse, rhs: FlickrPhotoResponse) -> Bool {
    return lhs.url() == rhs.url()
}
