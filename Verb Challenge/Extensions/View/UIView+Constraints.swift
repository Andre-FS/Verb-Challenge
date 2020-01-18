//
//  UIView+Constraints.swift
//  Verb Challenge
//
//  Created  on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Internal
    
    func fittedConstraints() -> [NSLayoutConstraint] {
        
        var newContraints = self.constraints(fromView: self, visualFormat: "H:|[view]|")
        newContraints += self.constraints(fromView: self, visualFormat: "V:|[view]|")
        
        return newContraints
        
    }
    
    
    // MARK: - Private
    
    private func constraints(fromView: UIView, visualFormat: String) -> [NSLayoutConstraint] {
        
        let views = ["view": fromView]
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                                         options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                         metrics: nil,
                                                         views: views)
        
        return constraints
        
    }
    
}
