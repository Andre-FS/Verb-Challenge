//
//  PhotoCell.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit
import Nuke

class PhotoCell: BaseCell {

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: PhotoCellActionDelegate?
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setupGestureRecognizer()
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        Nuke.cancelRequest(for: self.imageView)
        
    }
    
    // MARK: - Internal
    
    override func setupWithContent(_ content: Any) {
        
        super.setupWithContent(content)
        
        guard let model = content as? PhotoCellViewModel else {
            
            print("Unexpected content type in PhotoCell")
            return
            
        }
        
        loadPhoto(from: model)
        
    }
    
    
    // MARK: - Private
    
    private func loadPhoto(from model: PhotoCellViewModel) {
        
        let options = ImageLoadingOptions(transition: .custom({ [weak self] (_, image) in
            
            guard let self = self else {
                return
            }
            
            UIView.transition(with: self.imageView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { self.imageView.image = image })
            
        }))
        
        Nuke.loadImage(with: model.url, options: options, into: self.imageView)
        
    }
    
    private func setupGestureRecognizer() {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellDidTap))
        self.actionButton.addGestureRecognizer(tapRecognizer)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellDidLongPress))
        self.actionButton.addGestureRecognizer(longPressGesture)
        
    }
    

    // MARK: - Actions
    
    @objc
    func cellDidTap() {
        self.delegate?.didTap(on: self)
    }
    
    @objc
    func cellDidLongPress(_ sender: UIGestureRecognizer) {
        
        if sender.state == .began {
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.delegate?.didLongPress(on: self)
            
        }
        
    }
    
}

struct PhotoCellViewModel {
    var url: URL
}

protocol PhotoCellActionDelegate: class {
    
    func didTap(on cell: PhotoCell)
    func didLongPress(on cell: PhotoCell)
    
}
