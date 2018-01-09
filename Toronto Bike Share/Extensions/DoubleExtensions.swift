//
//  DoubleExtensions.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-06.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the given `Double` to two decimal places
    func round() -> Double {
        return (self * 100).rounded() / 100
    }
}
