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
    var photoStorage: PhotoStorage
    var homeService: HomeService
    var rawPhotoData = [Photo]()
    var homeData: PublishSubject<[PhotoCellViewModel]> = PublishSubject()
    var dataStatus: PublishSubject<HomeDataState> = PublishSubject()
    
    var updateTask: HTTPManagerTask?
    
    
    // MARK: - Life Cycle
    
    init(networkLayer: NetworkLayer, photoStorage: PhotoStorage) {
        self.networkLayer = networkLayer
        self.photoStorage = photoStorage
        self.homeService = HomeService(networkLayer: networkLayer)
    }
    
    
    // MARK: - Internal
    
    func triggerPhotoUpdate() {
        
        self.dataStatus.onNext(.loading)
        
        self.updateTask?.cancel()
        self.updateTask = self.homeService.getVacationPhotos { [weak self] in
            
            switch $0 {
            case let .success(photos):
                self?.handlePhotos(photos)
                
            case let .failure(error):
                self?.handlePhotoLoadingError(error)
                
            }
            
        }
        
    }
    
    
    // MARK: - Private
    
    private func photoCellViewModels(from photos: [Photo]) -> [PhotoCellViewModel] {
        return photos.compactMap({ $0.url }).map { PhotoCellViewModel(url: $0) }
    }
    
    private func handlePhotos(_ photos: [Photo]) {
        
        self.rawPhotoData = photos
        self.photoStorage.storePhotos(photos.compactMap({ $0.url }).map { StorablePhoto(url: $0) })
        
        self.homeData.onNext(self.photoCellViewModels(from: photos))
        self.dataStatus.onNext(.success)
        
    }
    
    private func handlePhotoLoadingError(_ error: Error) {
        
        let storedPhotos = self.photoStorage.retrievePhotos()
        
        if storedPhotos.isEmpty {
            
            self.homeData.onNext([])
            self.dataStatus.onNext(.error)
            
        } else {
            
            self.rawPhotoData = storedPhotos
            self.homeData.onNext(self.photoCellViewModels(from: storedPhotos))
            self.dataStatus.onNext(.offline)
            
        }
        
    }
    
}

enum HomeDataState {
    case success
    case loading
    case error
    case offline
}
