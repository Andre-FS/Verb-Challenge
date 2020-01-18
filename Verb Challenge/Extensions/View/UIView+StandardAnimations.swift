//
//  UIView+StandardAnimations.swift
//  Verb Challenge
//
//  Created on 18/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import UIKit

typealias GenericHandler = () -> Void
typealias AnimationCompletionHandler = (Bool) -> Void

extension UIView {
    
    // MARK: - Static
    
    static func standardAnimation(delay: TimeInterval = 0,
                                  animations: @escaping GenericHandler,
                                  completion: AnimationCompletionHandler? = nil) {
        
        UIView.animate(withDuration: 0.6,
                       delay: delay,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .beginFromCurrentState,
                       animations: animations,
                       completion: completion)
        
    }
    
    
    // MARK: - Internal
    
    func standardAnimationFromTransform(_ from: CGAffineTransform,
                                        delay: TimeInterval = 0,
                                        completion: AnimationCompletionHandler? = nil) {
        
        self.alpha = 0
        self.transform = from
        
        UIView.standardAnimation(delay: delay, animations: {
            
            self.alpha = 1
            self.transform = .identity
            
        }, completion: completion)
        
    }
    
}
