//
//  AppCoordinator.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit
import Nuke

class AppCoordinator: CoordinatorNavigationDelegate {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController!
    
    
    // MARK: - Internal
    
    func startingViewController() -> UIViewController {
        
        let flickr = Flickr()
        let networkLayer = NetworkLayer(hostname: flickr.hostname)
        let photoStorage = PhotoStorage()
        
        let homeViewModel = HomeViewModel(networkLayer: networkLayer, photoStorage: photoStorage)
        guard let homeViewController = HomeViewController.instantiateFromStoryboard(creator: {
            return HomeViewController(coder: $0, viewModel: homeViewModel, navigationDelegate: self)
        }) else {
            fatalError("⚠️ AppCoordinator - Unable to instantiate HomeViewController")
        }
        
        self.navigationController = UINavigationController(rootViewController: homeViewController)
        return navigationController
        
    }
    
    func navigateToPhotoDetail(with photo: Photo, from viewController: UIViewController) {
        
        let viewModel = PhotoDetailViewModel(photo: photo)
        
        guard let detailViewController = PhotoDetailViewController.instantiateFromStoryboard(creator: {
            PhotoDetailViewController(coder: $0, viewModel: viewModel, navigationDelegate: self)
        }) else {
            fatalError("⚠️ AppCoordinator - Unable to instantiate PhotoDetailViewController")
        }
        
        viewController.present(detailViewController, animated: true)
        
    }
    
    func share(photo: Photo, from viewController: UIViewController) {
        
        guard let photoURL = photo.url else {
            return
        }
        
        let items = [photoURL]
        let shareVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.present(shareVC, animated: true)
        
    }
    
}

protocol CoordinatorNavigationDelegate: class {
    
    func navigateToPhotoDetail(with photo: Photo, from viewController: UIViewController)
    func share(photo: Photo, from viewController: UIViewController)
    
}
