//
//  StatusBarBackgroundView.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit

final class StatusBarBackgroundView: UIView {
    // MARK: - Lifecycle Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Helper Functions
    private func configure() {
        // In compliance with the Human Interface Guidelines, the map cannot be directly behind the status bar. For this app, the background of the status bar should be blurred.
        //TODO: This is kinda hacky
        let heightConstraint = constraints.first(where: { $0.firstAttribute == .height })
        heightConstraint?.constant = UIApplication.shared.statusBarFrame.height
        
        applyBlurEffect(using: .regular)
    }
}
