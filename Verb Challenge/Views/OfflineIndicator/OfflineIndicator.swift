//
//  OfflineIndicator.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class OfflineIndicator: AutoLayoutXIB {

    // MARK: - Outlets
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var actionButton: TapFeedbackButton!
    
    
    // MARK: - Life Cycle
    
    override func setup() {
        
        super.setup()
        
        self.setupUI()
        
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        self.label.text = NSLocalizedString("Home.OfflineIndicator.Text", comment: "")
    }
    
}
