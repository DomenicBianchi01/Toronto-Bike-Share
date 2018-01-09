//
//  SystemFeeds.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

struct SystemFeeds: Codable {
    let data: SystemData
}

struct SystemData: Codable {
    let english: Feeds
    
    enum CodingKeys: String, CodingKey {
        case english = "en"
    }
}

struct Feeds: Codable {
    let feeds: [Urls]
}

struct Urls: Codable {
    let url: String
}
