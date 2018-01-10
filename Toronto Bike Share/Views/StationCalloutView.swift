//
//  StationCalloutView.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit
import MapKit

final class StationCalloutView: UIView {
    // MARK: - IBOutlets
    @IBOutlet var stationNameLabel: UILabel!
    @IBOutlet var availableBikesLabel: UILabel!
    @IBOutlet var availableDocksLabel: UILabel!
    @IBOutlet var directionsButton: UIButton!
    
    // MARK: Properties
    private var annotation: MKAnnotation? = nil
    
    // MARK: - Helper Functions
    func configureView(for annotation: MKAnnotation) {
        NotificationCenter.default.post(name: .clearDirections, object: nil, userInfo: nil)
        self.annotation = annotation
        stationNameLabel.text = annotation.title ?? "Unknown Station"
        
        if let stationAnnotation = annotation as? Station  {
            availableBikesLabel.text = String(stationAnnotation.stationDetail.bikesAvailable)
            availableDocksLabel.text = String(stationAnnotation.stationDetail.docksAvailable)
        } else {
            availableBikesLabel.text = "?"
            availableDocksLabel.text = "?"
        }
        
        stationNameLabel.sizeToFit()
        directionsButton.titleLabel?.textAlignment = .center
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .denied || authorizationStatus == .restricted || authorizationStatus == .notDetermined {
            directionsButton.isEnabled = false
            directionsButton.backgroundColor = .lightGray
            directionsButton.titleLabel?.numberOfLines = 2
            directionsButton.titleLabel?.minimumScaleFactor = 0.5
            directionsButton.titleLabel?.adjustsFontSizeToFitWidth = true
            directionsButton.setTitle("Enable Location Services to get directions", for: .normal)
        }
        
        let height = subviews.reduce(0) {
            $0 + $1.frame.height
        }

        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
    }
    
    // MARK: - IBActions
    @IBAction func directionsButtonTapped(_ sender: Any) {
        // NOTE: Routing directions for Transit is not supported as of iOS 11. You can only request for Transit ETA times.
        let alertController = UIAlertController(title: "Directions", message: "Select the type of directions you would like", preferredStyle: .actionSheet)
        
        let walkingDirections = UIAlertAction(title: "Walking", style: .default) { (UIAlertAction) in
            NotificationCenter.default.post(name: .directionsRequested, object: nil, userInfo: [NotificationKeys.directionsType : MKDirectionsTransportType.walking, NotificationKeys.destinationCoordinates : self.annotation?.coordinate as Any])
        }
        
        let automobileDirections = UIAlertAction(title: "Automobile", style: .default) { (UIAlertAction) in
            NotificationCenter.default.post(name: .directionsRequested, object: nil, userInfo: [NotificationKeys.directionsType : MKDirectionsTransportType.automobile, NotificationKeys.destinationCoordinates : self.annotation?.coordinate as Any])
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(walkingDirections)
        alertController.addAction(automobileDirections)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = self
        alertController.popoverPresentationController?.sourceRect = bounds

        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
