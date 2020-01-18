//
//  TapFeedbackButton.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit

class TapFeedbackButton: UIButton {
    
    // MARK: - IBInspectable
    
    @IBInspectable var scaleFactor: CGFloat = 0.97
    
    
    // MARK: - Outlets
    
    @IBOutlet var customFeedbackViews: [UIView]?
    
    
    // MARK: - Overridable
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        animateScale(self.scaleFactor)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        animateScale(1)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        animateScale(1)
        
    }
    
    
    // MARK: - Private
    
    func animateScale(_ scale: CGFloat) {
        
        let feedbackViews = self.customFeedbackViews ?? [self]
        
        feedbackViews.forEach { view in
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: { view.transform = CGAffineTransform(scaleX: scale, y: scale) },
                           completion: nil)
            
        }
        
    }
    
}
