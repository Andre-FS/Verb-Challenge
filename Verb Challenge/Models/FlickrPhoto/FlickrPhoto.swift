//
//  FlickrPhoto.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

private let FlickrPhotoURLTemplate = "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_c.png"

struct FlickrPhoto: Photo, Decodable {
    
    // MARK: - Properties
    
    var id: String
    var secret: String
    var server: String
    var farm: Int
    
    
    // MARK: - Computed Properties
    
    var url: URL? {
        
        let urlString = FlickrPhotoURLTemplate
            .replacingOccurrences(of: PhotoTemplateVariable.farm.rawValue, with: "\(self.farm)")
            .replacingOccurrences(of: PhotoTemplateVariable.server.rawValue, with: "\(self.server)")
            .replacingOccurrences(of: PhotoTemplateVariable.id.rawValue, with: "\(self.id)")
            .replacingOccurrences(of: PhotoTemplateVariable.secret.rawValue, with: "\(self.secret)")
        
        return URL(string: urlString)
        
    }
}

private enum PhotoTemplateVariable: String {
    case farm = "{farm-id}"
    case server = "{server-id}"
    case id = "{id}"
    case secret = "{secret}"
}
