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
    var homeData: PublishSubject<[PhotoCellViewModel]> = PublishSubject()
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
            
            guard let self = self else {
                return
            }
            
            switch $0 {
            case let .success(photos):
                self.homeData.onNext(self.photoCellViewModels(from: photos))
                self.dataStatus.onNext(.success)
                
            case let .failure(error):
                print(error)
                self.homeData.onNext([])
                self.dataStatus.onNext(.error)
            }
            
        }
        
    }
    
    
    // MARK: - Private
    
    private func photoCellViewModels(from photos: [Photo]) -> [PhotoCellViewModel] {
        return photos.compactMap({ $0.url }).map { PhotoCellViewModel(url: $0) }
    }
    
}

enum HomeDataState {
    case success
    case loading
    case error
}
