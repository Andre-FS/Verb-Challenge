//
//  StorablePhoto.swift
//  Verb Challenge
//
//  Created by André Silva on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import RealmSwift

class StorablePhoto: Object, Photo {
    
    // MARK: - Properties
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    @objc dynamic var urlString: String
    
    
    // MARK: - Static
    
    override static func primaryKey() -> String? {
        return "urlString"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["url"]
    }
    
    
    // MARK: - Init {
    
    init(url: URL) {
        self.urlString = url.absoluteString
    }
    
    required init() {
        self.urlString = ""
    }
    
}
