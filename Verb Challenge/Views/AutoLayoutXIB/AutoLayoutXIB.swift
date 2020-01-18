//
//  AutoLayoutXIB.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class AutoLayoutXIB: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var view: UIView?
    
    
    // MARK: - Properties
    
    var customConstraints = [NSLayoutConstraint]()
    
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
        
    }
    
    required init() {
        
        super.init(frame: CGRect.zero)
        setup()
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        
    }
    
    
    // MARK: - Life Cycle
    
    override func updateConstraints() {
        
        removeConstraints(customConstraints)
        self.customConstraints.removeAll()
        
        if let view = self.view {
            
            let fittedConstraints = view.fittedConstraints()
            self.customConstraints.append(contentsOf: fittedConstraints)
            addConstraints(fittedConstraints)
            
        }
        
        super.updateConstraints()
        
    }
    
    
    // MARK: - Setup
    
    open func setup() {
        
        customConstraints = [NSLayoutConstraint]()
        
        let view = loadFromNib()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        setNeedsUpdateConstraints()
        self.view = view
        
    }
    
}
