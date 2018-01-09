//
//  DirectionsViewController.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit
import MapKit

final class DirectionsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var etaLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var route: MKRoute? = nil {
        didSet {
            guard let route = route else {
                etaLabel.text = "Unknown Travel Time"
                return
            }
            etaLabel.text = "About \(String(Int(route.expectedTravelTime / 60))) minutes"
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBlurEffect(using: .extraLight)
        view.addShadow()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

// MARK: - <UITableViewDataSource>
extension DirectionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteStepReuseIdentifier", for: indexPath)
        
        if let routeStepCell = cell as? RouteStepTableViewCell {
            routeStepCell.routeStep = route?.steps[indexPath.row]
        }
        
        return cell
    }
}
