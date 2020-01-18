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
    @IBOutlet weak var scrollView: UIScrollView!
    
    
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
        
        setupImageView()
        setupScrollView()
        
    }
    
    private func setupImageView() {
        
        guard let photoURL = self.viewModel.photo.url else {
            return
        }
        
        Nuke.loadImage(with: photoURL, into: self.imageView)
        
    }
    
    private func setupScrollView() {
        
        self.scrollView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.scrollView.maximumZoomScale = 3
        self.scrollView.minimumZoomScale = 1
        self.scrollView.zoomScale = 1
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 2
        
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
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
    
    // MARK: - Private
    
    @objc
    private func handleTap() {
        
        if self.scrollView.zoomScale > self.scrollView.minimumZoomScale {
            self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        } else {
            self.scrollView.setZoomScale((self.scrollView.minimumZoomScale + self.scrollView.maximumZoomScale) / 2, animated: true)
        }
        
    }
    
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
