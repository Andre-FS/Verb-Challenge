//
//  UIViewController+StoryboardInstantiation.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Internal
    
    static func instantiateFromStoryboard<T: UIViewController>() -> T? {

        let className = String(describing: self)

        if Bundle.main.path(forResource: className, ofType: "storyboardc") != nil {
            return UIStoryboard(name: className, bundle: nil).instantiateInitialViewController()
        }

        return nil
        
    }

}
