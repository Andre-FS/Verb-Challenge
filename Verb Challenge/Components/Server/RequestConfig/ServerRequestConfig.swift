//
//  ServerRequestConfig.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import PMHTTP

struct ServerRequestConfig {
    
    // MARK: - Properties
    
    let method: HTTPManagerRequest.Method
    let path: String
    let parameters: [String: Any]
    
    
    // MARK: - Init
    
    init(method: HTTPManagerRequest.Method, path: String, parameters: [String: Any]) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        
    }
    
}
