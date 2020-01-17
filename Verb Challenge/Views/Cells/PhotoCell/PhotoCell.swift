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
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        Nuke.cancelRequest(for: self.imageView)
        
    }
    
    // MARK: - Internal
    
    override func setupWithContent(_ content: Any, animated: Bool = false) {
        
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

}

struct PhotoCellViewModel {
    var url: URL
}
