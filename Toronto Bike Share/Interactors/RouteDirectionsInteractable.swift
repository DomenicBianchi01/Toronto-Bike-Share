//
//  RouteDirectionsInteractable.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-07.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation
import MapKit

protocol RouteDirectionsInteractable {
    /**
     Using `MapKit`, calculate a route from and to the given coordinates using the specificed transport type (automobile or walking)
     
     - parameter startLocation: Where the route should start
     - parameter endLocation: Where the route should end
     - parameter transportType: The type of directions that should be calculated (automobile or walking)
     - parameter completion: The completion block called when the route is calculated. If the route was calculated successfully, a `MKDirectionsResponse` object is included in the response. If the calculation failed, the object is nil.
     */
    func calculateRoute(from startLocation: CLLocationCoordinate2D,
                        to endLocation: CLLocationCoordinate2D,
                        by transportType: MKDirectionsTransportType,
                        completion: @escaping (MKDirections.Response?) -> Void)
}
