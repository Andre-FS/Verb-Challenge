//
//  PhotoBucket.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

struct PhotoBucket: Decodable {
    
    // MARK: - Properties
    
    var photos: PhotoBucketPage
    var stat: String
    
}

struct PhotoBucketPage: Decodable {
    
    // MARK: - Properties
    
    var photo: [FlickrPhoto]
    
}
