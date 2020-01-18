//
//  CustomNavigationController.swift
//  Verb Challenge
//
//  Created by André Silva on 18/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    // MARK: - Properties
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        let presentedSupportedOrientations = self.presentedViewController?.supportedInterfaceOrientations
        let topVCSupportedOrientations = self.topViewController?.supportedInterfaceOrientations
        
        return presentedSupportedOrientations ?? topVCSupportedOrientations ?? .portrait
        
    }
    
}
