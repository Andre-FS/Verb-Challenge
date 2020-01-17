//
//  HomeViewModel.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import RxSwift
import PMHTTP

class HomeViewModel {
    
    // MARK: - Properties
    
    var networkLayer: NetworkLayer
    var homeService: HomeService
    var homeData: PublishSubject<[Photo]> = PublishSubject()
    var dataStatus: PublishSubject<HomeDataState> = PublishSubject()
    
    var updateTask: HTTPManagerTask?
    
    
    // MARK: - Life Cycle
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
        self.homeService = HomeService(networkLayer: networkLayer)
    }
    
    
    // MARK: - Internal
    
    func triggerPhotoUpdate() {
        
        self.dataStatus.onNext(.loading)
        
        self.updateTask?.cancel()
        self.updateTask = self.homeService.getRecentPhotos { [weak self] in
            
            switch $0 {
            case let .success(photos):
                self?.homeData.onNext(photos)
                self?.dataStatus.onNext(.success)
                
            case let .failure(error):
                print(error)
                self?.homeData.onNext([])
                self?.dataStatus.onNext(.error)
            }
            
        }
        
    }
    
}

enum HomeDataState {
    case success
    case loading
    case error
}
