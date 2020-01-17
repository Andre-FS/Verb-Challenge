//
//  FlickrPhotoResponse.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

struct FlickrPhotoResponse: Decodable {
    
    // MARK: - Properties
    
    var photos: FlickrPhotoPage
    var stat: String
    
}

struct FlickrPhotoPage: Decodable {
    
    // MARK: - Properties
    
    var photo: [FlickrPhoto]
    
}
