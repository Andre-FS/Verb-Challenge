//
//  NetworkLayer.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

class NetworkLayer {
    
    // MARK: - Properties
    
    let hostname: String
    let requestMaker = ServerRequestMaker()
    
    
    // MARK: - Life Cycle
    
    init(hostname: String) {
        self.hostname = hostname
    }
    
    
    // MARK: - Internal
    
    func fullPathFor(path: String) -> String {
        return self.hostname.appending(path)
    }
    
}
