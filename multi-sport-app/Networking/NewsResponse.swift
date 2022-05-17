//
//  NewsResponse.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 17/5/2022.
//

import Foundation

struct NewsResponse<T: Decodable>: Decodable {
    let status: String
    let totalResults: Int?
    let articles: T?
}
