//
//  FlickrResponseModel.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/12/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol FlickrResponseModel {
    func title() -> String
    func photos() -> [FlickrPhotoResponse]
}
