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
        
        guard let homeViewController = HomeViewController.instantiateFromStoryboard() else {
            fatalError("⚠️ AppCoordinator - Unable to instantiate HomeViewController")
        }
        
        return homeViewController
        
    }
    
}
