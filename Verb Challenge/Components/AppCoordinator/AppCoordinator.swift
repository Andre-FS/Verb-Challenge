//
//  AppCoordinator.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    // MARK: - Internal
    
    func startingViewController() -> UIViewController {
        
        let flickr = Flickr()
        let networkLayer = NetworkLayer(hostname: flickr.hostname)
        
        guard let homeViewController = HomeViewController.instantiateFromStoryboard(creator: {
            return HomeViewController(coder: $0, viewModel: HomeViewModel(networkLayer: networkLayer))
        }) else {
            fatalError("⚠️ AppCoordinator - Unable to instantiate HomeViewController")
        }
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        return navigationController
        
    }
    
}
