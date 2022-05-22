//
//  WeatherResponse.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 22/5/2022.
//

import Foundation

struct WeatherResponse<T: Decodable>: Decodable {
    let forecast: T?
}
