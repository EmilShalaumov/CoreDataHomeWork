//
//  API.swift
//  CoreDataHomeWork
//
//  Created by Эмиль Шалаумов on 24.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

class API {
    
    private static let apiKey = "dab4052df3cc23ed39745a8cca163e0a"
    private static let baseUrl = "https://www.flickr.com/services/rest/"
    
    
    static func searchPath(text: String, extras: String) -> URL {
        guard var components = URLComponents(string: baseUrl) else {
            return URL(string: baseUrl)!
        }
        
        let methodItem = URLQueryItem(name: "method", value: "flickr.photos.search")
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let textItem = URLQueryItem(name: "text", value: text)
        let extrasItem = URLQueryItem(name: "extras", value: extras)
        let formatItem = URLQueryItem(name: "format", value: "json")
        let nojsoncallbackItem = URLQueryItem(name: "nojsoncallback", value: "1")
        let perPageItem = URLQueryItem(name: "per_page", value: "100")
        
        components.queryItems = [methodItem, apiKeyItem, textItem, extrasItem, formatItem, nojsoncallbackItem, perPageItem]
        
        return components.url!
    }
}
