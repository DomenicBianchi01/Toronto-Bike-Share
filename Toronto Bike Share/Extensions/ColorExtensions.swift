//
//  ColorExtensions.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2020-03-28.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    
    // MARK: Internal
    
    static let imageTintColor = UIColor { traits in
        if traits.userInterfaceStyle == .dark {
            return .white
        } else {
            return .black
        }
    }
}
