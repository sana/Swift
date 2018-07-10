//
//  Flickr.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import UIKit

class FlickrAPI {
    let defaultSession = URLSession(configuration: .default)
    var dataTasks: [URL: URLSessionDataTask] = [URL: URLSessionDataTask]()
    let serialQueue = DispatchQueue(label: "Flickr.dataTasks")

    func photosSearch(forSearchText searchText: String, completion: @escaping ((result: FlickrPhotosSearchResponse?, error: Error?)) -> Void) {
        if var urlComponents = URLComponents(string: FlickrConfiguration.flickrURL) {
            let methodQueryItem = URLQueryItem(name: "method", value: "flickr.photos.search")
            let apiKeyQueryItem = URLQueryItem(name: "api_key", value: FlickrConfiguration.apiKey)
            let formatQueryItem = URLQueryItem(name: "format", value: "json")
            let noJSONCallbackQueryItem = URLQueryItem(name: "nojsoncallback", value: "1")
            let textQueryItem = URLQueryItem(name: "text", value: searchText)
            urlComponents.queryItems = [methodQueryItem, apiKeyQueryItem, formatQueryItem, noJSONCallbackQueryItem, textQueryItem]
            if
                let url = urlComponents.url,
                dataTask(forURL: url) == nil
            {
                let dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        self?.set(dataTask: nil, forURL: url)
                    }
                    let photosSearch = FlickrPhotosSearchResponse(data: data, searchText: searchText)
                    completion((photosSearch, error: error))
                }
                self.set(dataTask: dataTask, forURL: url)
                dataTask.resume()
            }
        }
    }

    func getRecent(completion: @escaping ((result: FlickrGetRecentResponse?, error: Error?)) -> Void) {
        if var urlComponents = URLComponents(string: FlickrConfiguration.flickrURL) {
            let methodQueryItem = URLQueryItem(name: "method", value: "flickr.photos.getRecent")
            let apiKeyQueryItem = URLQueryItem(name: "api_key", value: FlickrConfiguration.apiKey)
            let formatQueryItem = URLQueryItem(name: "format", value: "json")
            let noJSONCallbackQueryItem = URLQueryItem(name: "nojsoncallback", value: "1")
            urlComponents.queryItems = [methodQueryItem, apiKeyQueryItem, formatQueryItem, noJSONCallbackQueryItem]
            if
                let url = urlComponents.url,
                dataTask(forURL: url) == nil
            {
                let dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        self?.set(dataTask: nil, forURL: url)
                    }
                    let getRecentResponse = FlickrGetRecentResponse(data: data)
                    completion((getRecentResponse, error: error))
                }
                self.set(dataTask: dataTask, forURL: url)
                dataTask.resume()
            }
        }
    }

    func fetch(imageAtURL url: String, completion: @escaping ((result: UIImage?, error: Error?)) -> Void) {
        if let URL = URL(string: url) {
            let dataTask = defaultSession.dataTask(with: URL) { [weak self] data, response, error in
                self?.set(dataTask: nil, forURL: URL)
                var image: UIImage?
                if let data = data {
                    image =  UIImage(data: data)
                } else {
                    image = nil
                }
                completion((result: image, error: error))
            }
            self.set(dataTask: dataTask, forURL: URL)
            dataTask.resume()
        }
    }

    // MARK :- Private helpers

    private func dataTask(forURL url: URL) -> URLSessionDataTask? {
        return serialQueue.sync {
            return self.dataTasks[url]
        }
    }

    private func set(dataTask: URLSessionDataTask?, forURL url: URL) {
        serialQueue.sync {
            self.dataTasks[url] = dataTask
        }
    }
}
