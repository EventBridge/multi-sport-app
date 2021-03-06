//
//  Route.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

enum Route {
    
    case allTeams
    case allPlayers
    case allArticles
    case allGames
    case standings
    case forecast
    
    var description: String {
        switch self {
        case .allTeams:
            return "/teams"
        case .allPlayers:
            return "/players"
        case .allArticles:
            return "/everything"
        case .allGames:
            return "/games"
        case .standings:
            return "/standings"
        case .forecast:
            return "/Forecast"
        }
    }
}
