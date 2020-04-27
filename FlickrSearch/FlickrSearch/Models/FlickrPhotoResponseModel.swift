//
//  FlickrPhotoResponse.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct FlickrPhotoResponseModel {
    let farmID: String
    let serverID: String
    let photoID: String
    let secret: String
    let title: String
}

extension FlickrPhotoResponseModel {
    init?(dictionary: [String : Any]?) {
        guard
            let dictionary = dictionary,
            let farmID = dictionary["farm"] as? Int,
            let serverID = dictionary["server"] as? String,
            let photoID = dictionary["id"] as? String,
            let secret = dictionary["secret"] as? String,
            let title = dictionary["title"] as? String
        else {
            return nil
        }
        self.farmID = String(farmID)
        self.serverID = serverID
        self.photoID = photoID
        self.secret = secret
        self.title = title
    }
}

extension FlickrPhotoResponseModel : Equatable { }
