//
//  RouteDirectionsInteractor.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-07.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation
import MapKit

final class RouteDirectionsInteractor {}

// MARK: - <RouteDirectionsInteractable>
extension RouteDirectionsInteractor: RouteDirectionsInteractable {
    func calculateRoute(from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D, by transportType: MKDirectionsTransportType, completion: @escaping (MKDirections.Response?) -> Void) {

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startLocation, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endLocation, addressDictionary: nil))
        request.transportType = transportType
        
        MKDirections(request: request).calculate { response, error in
            guard let response = response, error == nil else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
}
