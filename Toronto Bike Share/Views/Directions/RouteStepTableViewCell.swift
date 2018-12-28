//
//  RouteStepTableViewCell.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-06.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit
import MapKit

final class RouteStepTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var noticeLabel: UILabel!
    
    // MARK: - Properties
    var routeStep: MKRoute.Step? = nil {
        didSet {
            configure()
        }
    }

    // MARK: - Helper Functions
    private func configure() {
        var meters = 0.0
        var kilometers = 0.0
        if let routeStep = routeStep {
            meters = Double(routeStep.distance)
        }
        kilometers = (meters / 1000.0).round()
        
        if kilometers < 1.0 {
            distanceLabel.text = "\(Int(meters)) m"
        } else {
            distanceLabel.text = "\(kilometers) km"
        }

        descriptionLabel.text = routeStep?.instructions ?? "Unknown Instructions"
        noticeLabel.text = routeStep?.notice
    }
}
