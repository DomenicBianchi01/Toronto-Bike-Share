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
    @IBOutlet private var etaLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var closeWindowButton: UIButton!
    
    // MARK: - Properties
    var route: MKRoute? = nil {
        didSet {
            guard let route = route else {
                etaLabel.text = "Unknown Travel Time"
                return
            }
            etaLabel.text = "About \(Int(route.expectedTravelTime / 60)) minutes"
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBlurEffect(using: traitCollection.userInterfaceStyle == .dark ? .dark : .extraLight)
        view.addShadow()
        
        closeWindowButton.tintColor = UIColor.imageTintColor
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .clearDirections, object: nil, userInfo: nil)
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
