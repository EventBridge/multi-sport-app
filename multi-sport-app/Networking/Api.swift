//
//  Api.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 17/5/2022.
//

import Foundation

enum Api {
    case nbaApi
    case newsApi
    case weatherApi
    
    var baseUrl: String {
        switch self {
        case .nbaApi:
            return "https://api-nba-v1.p.rapidapi.com"
        case .newsApi:
            return "https://newsapi.org/v2"
        case .weatherApi:
            return "https://api.m3o.com/v1/weather"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .nbaApi:
            return [
                "application/json": "Content-Type",
                "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com",
                "X-RapidAPI-Key": "8d5bd343c6mshba3e1a0a7d42930p1d16a5jsn211d48e356bd"
            ]
        case .newsApi:
            return [
                "application/json": "Content-Type",
                "X-Api-Key": "d0c4fbf91f7d41ffb06ba98475e4d793"
            ]
        case .weatherApi:
            return [
                "application/json": "Content-Type",
                "Authorization": "Bearer NWZkOWU0MmQtZDgwMS00YmNjLTllZDMtNGQ2NzgwZWVlMzlm"
            ]
        }
    }
    
    var apiResponse: String {
        switch self {
        case .nbaApi:
            return "rapidResponse"
        case .newsApi:
            return "newsResponse"
        case .weatherApi:
            return "weatherResponse"
        }
    }
}
