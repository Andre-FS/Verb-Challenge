//
//  ServerRequestMaker.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import PMHTTP

private let TimeoutInterval: TimeInterval = 10

typealias ServerResponseHandler = (Result<Data, Error>) -> Void

class ServerRequestMaker {
    
    // MARK: - Internal
    
    func request(configuration: ServerRequestConfig, completionHandler: @escaping ServerResponseHandler) -> HTTPManagerTask {
        
        let request = HTTP.request(GET: configuration.path, parameters: configuration.parameters)!
        request.timeoutInterval = TimeoutInterval
        
        let task = request.performRequest(withCompletionQueue: .main) { _, result in
            switch result {
            case let .success(_, data):
                completionHandler(.success(data))
                
            case let .error(_, error):
                completionHandler(.failure(error))
                
            case .canceled:
                break
            }
        }
        
        return task
        
    }
    
}
