//
//  ServerRequestMaker.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import PMHTTP
import RxSwift

class ServerRequestMaker {
    
    // MARK: - Internal
    
    func request(configuration: ServerRequestConfig) -> Single<Data> {
        
        return Single.create { single in
            
            let task = HTTP.request(GET: configuration.path, parameters: configuration.parameters)
                .performRequest(withCompletionQueue: .main) { _, result in
                    switch result {
                    case let .success(_, data):
                        single(.success(data))
                        
                    case let .error(_, error):
                        single(.error(error))
                        
                    case .canceled:
                        break
                    }
            }
            
            return Disposables.create {
                task.cancel()
            }
            
        }
        
    }
    
}
