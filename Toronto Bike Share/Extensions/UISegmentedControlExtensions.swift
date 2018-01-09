//
//  UISegmentedControlExtensions.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    /// Enables `adjustsFontSizeToFitWidth` and `minimumScaleFactor` for all labels in the segmented control. For devices with a smaller screen, the label sizes need to be shrunk to make sure they fit on one line without being cut off
    func enableScaleFactor() {
        for subview in subviews {
            for anotherSubview in subview.subviews {
                guard let label = anotherSubview as? UILabel else {
                    continue
                }
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
            }
        }
    }
}
