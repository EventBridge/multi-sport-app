//
//  Route.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

enum Route {
    static let baseUrl = "https://api-nba-v1.p.rapidapi.com"
    
    case allTeams
    case allPlayers
    
    var description: String {
        switch self {
        case .allTeams:
            return "/teams"
        case .allPlayers:
            return "/players"
        }
    }
}
