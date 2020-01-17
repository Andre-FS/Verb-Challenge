//
//  PhotoDetailViewController.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class PhotoDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Properties
    
    let viewModel: PhotoDetailViewModel
    
    
    // MARK: - Init
    
    init?(coder: NSCoder, viewModel: PhotoDetailViewModel) {
        
        self.viewModel = viewModel
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("PhotoDetailViewController must be initialized with a viewModel.")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    // MARK: - Private
    
    private func setupUI() {
        Nuke.loadImage(with: self.viewModel.photoModel.url, into: self.imageView)
    }
    
}
