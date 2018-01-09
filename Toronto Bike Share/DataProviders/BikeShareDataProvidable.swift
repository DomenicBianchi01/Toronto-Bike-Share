//
//  BikeShareDataProvidable.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation

protocol BikeShareDataProvidable {
    /**
     Fetch JSON data and parse it according to the `type` parameter in the function.
     
     - parameter urlString: A raw string of the URL that contains the JSON data. This function will attempt to convert the raw string into a `URL` object.
     - parameter type: The structure that the fetched JSON data should be parsed according to. NOTE: The structure must conform to `Decodable`.
     - parameter completion: If the function successfully fetched and parsed the JSON data, the completion block includes the parsed data as a structure that matches the type passed in the `type` parameter of this function. If the function could not parse the data, the completion block includes a nil object instead.
     */
    func fetchBikeShareData<T: Decodable>(from urlString: String, using type: T.Type, completion: @escaping (T?) -> Void)
}
