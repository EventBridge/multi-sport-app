//
//  TeamStanding.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 19/5/2022.
//

import Foundation

struct TeamStanding: Decodable {
    let league: String?
    let season: Int?
    let team: TeamSub?
    let conference, division: Conference?
    let win, loss: Loss?
    let gamesBehind: String?
    let streak: Int?
    let winStreak: Bool?
}

struct Conference: Codable {
    let name: String?
    let rank, win, loss: Int?
    let gamesBehind: String?
}

struct Loss: Codable {
    let home, away, total: Int?
    let percentage: String?
    let lastTen: Int?
}

struct TeamSub: Codable {
    let id: Int?
    let name, nickname, code: String?
    let logo: String?
}
