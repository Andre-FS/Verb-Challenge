//
//  Flickr.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

class Flickr {
    
    let hostname = "https://www.flickr.com"
    let apiKey = "7959f38994c7b5125367ee852fb863f9"
    
    enum APIMethod {
        case getRecentPhotos
        
        func parameters() -> [String: Any] {
            
            switch self {
            case .getRecentPhotos:
                return ["method": "flickr.photos.getRecent",
                        "format": "json",
                        "nojsoncallback": "1",
                        "api_key": "7959f38994c7b5125367ee852fb863f9"]
            }
            
        }
        
        func path() -> String {
            
            switch self {
            case .getRecentPhotos:
                return "/services/rest"
            }
            
        }
    }
    
}
