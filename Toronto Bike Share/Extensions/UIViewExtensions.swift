//
//  UIViewExtensions.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit

extension UIView {
    /// Applies a blue effect using the specified style to the view. This function has no effect on the view if the user has turned on the "Reduce Transparency" option in the iOS settings.
    func applyBlurEffect(using style: UIBlurEffect.Style) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(blurEffectView, at: 0)
        }
    }
    
    /// Adds a thin black shadow along the border of all four edges of the view
    func addShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
    }
    
    /// Calls `layoutIfNeeded()` on the view with an animation duration of 0.5 seconds
    func refreshView() {
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}
