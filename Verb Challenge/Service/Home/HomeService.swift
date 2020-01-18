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
    
    func getVacationPhotos(completion: @escaping PhotosResponseHandler) -> HTTPManagerTask {
        
        let method = Flickr.APIMethod.getVacationPhotos
        let configuration = ServerRequestConfig(method: .GET,
                                                path: networkLayer.fullPathFor(path: method.path()),
                                                parameters: method.parameters())
        
        return networkLayer.requestMaker.request(configuration: configuration, completionHandler: {
            
            switch $0 {
            case let .success(data):
                
                do {
                    
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(FlickrPhotoResponse.self, from: data)
                    
                    completion(.success(model.photos.photo))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        })
        
    }
    
}
