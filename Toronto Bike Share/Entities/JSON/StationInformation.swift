//
//  StationInformation.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

struct StationsInfo: Codable {
    let data: Data
}

struct Data: Codable {
    let stations: [Stations]
}

struct Stations: Codable {
    let id: String
    let name: String
    let lat: Double
    let long: Double
    let capacity: Int

    enum CodingKeys: String, CodingKey {
        case id = "station_id"
        case name
        case lat
        case long = "lon"
        case capacity
    }
}
