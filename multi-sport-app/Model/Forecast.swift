//
//  Weather.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 22/5/2022.
//

import Foundation

struct Forecast: Decodable {
    let date: String?
    let max_temp_c: Double?
    let min_temp_c: Double?
    let chance_of_rain: Double?
    let condition: String?
}
