//
//  UIView+LoadFromNIB.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Public
    
    public func loadFromNib<T: UIView>() -> T {
        
        let nib = UINib(nibName: String(describing: self.classForCoder), bundle: Bundle(for: self.classForCoder))
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("⚠️ Unable to instantiate NIB while type-casting to \(String(describing: self))")
        }
        
        return view
        
    }
    
}
