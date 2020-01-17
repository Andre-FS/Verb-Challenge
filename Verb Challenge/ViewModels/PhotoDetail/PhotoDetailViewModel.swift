//
//  PhotoDetailViewModel.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
    
    // MARK: - Properties
    
    let photoModel: PhotoCellViewModel
    
    
    // MARK: - Init
    
    init(photoModel: PhotoCellViewModel) {
        self.photoModel = photoModel
    }
}
