//
//  FlickrGetRecentResponse.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct FlickrGetRecentResponse {
    let queryTimestamp: String
    let photoResponses: [FlickrPhotoResponse]
}

extension FlickrGetRecentResponse {
    init?(data: Data?) {
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

            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            if
                let year = components.year,
                let month = components.month,
                let day = components.day,
                let hour = components.hour,
                let minute = components.minute,
                let second = components.second
            {
                queryTimestamp = "Pictures at \(year)/\(month)/\(day) \(hour):\(minute):\(second)"
            } else {
                queryTimestamp = "Pictures from Flickr"
            }
        } catch {
            return nil
        }
    }
}

extension FlickrGetRecentResponse : FlickrResponseModel {
    func title() -> String {
        return queryTimestamp
    }

    func photos() -> [FlickrPhotoResponse] {
        return photoResponses
    }
}
