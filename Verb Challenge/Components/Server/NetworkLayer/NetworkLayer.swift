//
//  NetworkLayer.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import PMHTTP

class NetworkLayer {
    
    // MARK: - Properties
    
    let hostname: String
    let requestMaker = ServerRequestMaker()
    
    
    // MARK: - Life Cycle
    
    init(hostname: String) {
        self.hostname = hostname
    }
    
    
    // MARK: - Internal
    
    func get(method: Flickr.APIMethod, completionHandler: @escaping ServerResponseHandler) -> HTTPManagerTask {
        
        let method = Flickr.APIMethod.getVacationPhotos
        let configuration = ServerRequestConfig(method: .GET,
                                                path: self.fullPathFor(path: method.path()),
                                                parameters: method.parameters())
        
        return self.requestMaker.request(configuration: configuration, completionHandler: completionHandler)
        
    }
    
    func fullPathFor(path: String) -> String {
        return self.hostname.appending(path)
    }
    
}
