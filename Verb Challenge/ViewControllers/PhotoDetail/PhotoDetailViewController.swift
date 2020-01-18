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
    weak var navigationDelegate: CoordinatorNavigationDelegate?
    
    
    // MARK: - Init
    
    init?(coder: NSCoder, viewModel: PhotoDetailViewModel, navigationDelegate: CoordinatorNavigationDelegate) {
        
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("PhotoDetailViewController must be initialized with a viewModel.")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        setupShareAction()
        
    }
    
    // MARK: - Private
    
    private func setupUI() {
        
        guard let photoURL = self.viewModel.photo.url else {
            return
        }
        
        Nuke.loadImage(with: photoURL, into: self.imageView)
        
    }
    
    private func setupShareAction() {
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(photoDidLongPress))
        self.imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    // MARK: - Actions
    
    @objc
    func photoDidLongPress(_ sender: UIGestureRecognizer) {
        
        if sender.state == .began {
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.navigationDelegate?.share(photo: self.viewModel.photo, from: self)
            
        }
            
    }
    
}
