//
//  StationStatus.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-04.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

struct StationDetails: Codable {
    let data: StatusData
}

struct StatusData: Codable {
    let stations: [StationDetail]
}

struct StationDetail: Codable {
    let id: String
    let bikesAvailable: Int
    let bikesDisabled: Int
    let docksAvailable: Int
    let docksDisabled: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "station_id"
        case bikesAvailable = "num_bikes_available"
        case bikesDisabled = "num_bikes_disabled"
        case docksAvailable = "num_docks_available"
        case docksDisabled = "num_docks_disabled"
    }
}
