//
//  ApiResponse.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    // TODO Fix error handling for server errors[] response
    let errors: [String]?
    let results: Int?
    let response: T?
}
