//
//  StationInfoDataProvider.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

final class StationInfoDataProvider {}

// MARK: - <BikeShareDataProvidable>
extension StationInfoDataProvider: BikeShareDataProvidable {
    func fetchBikeShareData<T: Decodable>(from urlString: String, using type: T.Type, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        do {
            let jsonString = try String(contentsOf: url, encoding: .ascii)
            if let jsonData = jsonString.data(using: .utf8) {
                let json = try JSONDecoder().decode(type, from: jsonData)
                completion(json)
                return
            }
        }
        catch(let error) {
            print(error)
        }
        completion(nil)
    }
}
