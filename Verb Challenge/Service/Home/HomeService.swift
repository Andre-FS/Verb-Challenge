//
//  HomeService.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import PMHTTP

typealias PhotosResponseHandler = (Result<[Photo], Error>) -> Void

class HomeService {
    
    // MARK: - Properties
    
    private let networkLayer: NetworkLayer
    
    
    // MARK: - Init
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    
    // MARK: - Internal
    
    func getRecentPhotos(completion: @escaping PhotosResponseHandler) -> HTTPManagerTask {
        
        let method = Flickr.APIMethod.getRecentPhotos
        let configuration = ServerRequestConfig(method: .GET,
                                                path: networkLayer.fullPathFor(path: method.path()),
                                                parameters: method.parameters())
        
        return networkLayer.requestMaker.request(configuration: configuration, completionHandler: {
            
            switch $0 {
            case let .success(data):
                // TODO: convert to model
                completion(.success([Photo()]))
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        })
        
    }
    
}
