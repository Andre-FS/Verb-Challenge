//
//  UICollectionView+CellReuse.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

import UIKit

extension UICollectionView {
    
    // MARK: - Internal
    
    func register(cellClass: Swift.AnyClass) {
        
        let nibName = String(describing: cellClass)
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        
    }
    
}
