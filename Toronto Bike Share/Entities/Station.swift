//
//  Station.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation
import MapKit

final class Station: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let stationDetail: StationDetail
    
    init(title: String, coordinate: CLLocationCoordinate2D, stationDetail: StationDetail) {
        self.title = title
        self.coordinate = coordinate
        self.stationDetail = stationDetail
        super.init()
    }
}
