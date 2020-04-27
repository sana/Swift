//
//  ImageCache.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 5/3/20.
//  Copyright © 2020 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import UIKit

final class ImageCache {
    private let cache = NSCache<NSString, UIImage>()

    subscript(index: NSString) -> UIImage? {
        get {
            return cache.object(forKey: index)
        }
        set(newValue) {
            if let nonNilValue = newValue {
                cache.setObject(nonNilValue, forKey: index)
            } else {
                cache.removeObject(forKey: index)
            }
        }
    }

}
