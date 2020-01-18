//
//  HomeLayoutUpdater.swift
//  Verb Challenge
//
//  Created on 18/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class HomeLayoutUpdater {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    private var offlineIndicator: OfflineIndicator!
    private var hasAnimatedIn = false
    
    
    // MARK: - Setup
    
    func setupWith(collectionView: UICollectionView,
                   activityIndicator: UIActivityIndicatorView,
                   offlineIndicator: OfflineIndicator) {
        
        self.collectionView = collectionView
        self.activityIndicator = activityIndicator
        self.offlineIndicator = offlineIndicator
        
    }
    
    
    // MARK: - Internal
    
    func updateViewVisibility(for state: HomeDataState) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
            
            switch state {
            case .success, .offline:
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1
                self.collectionView.refreshControl?.endRefreshing()
                
            case .loading:
                if self.collectionView.refreshControl?.isRefreshing != true {
                    self.activityIndicator.startAnimating()
                    self.collectionView.alpha = 0
                }
                
            case .error:
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 0
                self.collectionView.refreshControl?.endRefreshing()
            }
            
        })
        
    }
    
    func updateOfflineIndicator(for state: HomeDataState) {
        
        UIView.standardAnimation(animations: {
            
            if [HomeDataState.offline, HomeDataState.error].contains(state) {
                
                self.offlineIndicator.alpha = 1
                self.offlineIndicator.transform = .identity
                
            } else {
                
                self.offlineIndicator.alpha = 0
                self.offlineIndicator.transform = CGAffineTransform(translationX: self.offlineIndicator.bounds.width, y: 0)
                
            }
            
        })
        
    }
    
    func applyDisplayAnimationIfNeededTo(cell: UICollectionViewCell, at indexPath: IndexPath) {
        
        guard !self.hasAnimatedIn else {
            return
        }
        
        let delay = TimeInterval(indexPath.row) * 0.04
        
        cell.standardAnimationFromTransform(CGAffineTransform(translationX: 0, y: 20),
                                            delay: delay,
                                            completion: { _ in
                                                self.hasAnimatedIn = true
        })
        
    }
    
}
