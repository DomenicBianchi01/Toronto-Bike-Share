//
//  NotificationExtensions.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-04.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let directionsRequested = Notification.Name(rawValue: "com.domenic.bianchi.Toronto-Bike-Share.directions.requested")
    static let clearDirections = Notification.Name(rawValue: "com.domenic.bianchi.Toronto-Bike-Share.clear.directions")
}

struct NotificationKeys {
    static let directionsType = "DirectionsType"
    static let destinationCoordinates = "DestinationCoordinates"
}
