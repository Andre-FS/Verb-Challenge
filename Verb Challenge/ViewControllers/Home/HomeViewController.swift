//
//  HomeViewController.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
    }
    
    
    // MARK: - Private
    
    private func setup() {
        self.title = NSLocalizedString("Home.Title", comment: "")
    }

}
