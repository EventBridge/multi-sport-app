//
//  Game.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 19/5/2022.
//

import Foundation

struct Game: Codable {
    let id: Int?
    let league: String?
    let season: Int?
    let date: DateClass?
    let stage: Int?
    let status: Status?
    let periods: Periods?
    let arena: Arena?
    let teams: Teams?
    let scores: Scores?
    let officials: [String]?
    let timesTied, leadChanges: Int?
}

struct Arena: Codable {
    let name, city, state, country: String?
}

struct DateClass: Codable {
    let start, end, duration: String?
}

struct Periods: Codable {
    let current, total: Int?
    let endOfPeriod: Bool?
}

struct Scores: Codable {
    let visitors, home: ScoresHome?
}

struct ScoresHome: Codable {
    let win, loss: Int?
    let series: Series?
    let linescore: [String]?
    let points: Int?
}

struct Series: Codable {
    let win, loss: Int?
}

struct Status: Codable {
    let halftime: Bool?
    let short: Int?
    let long: String?
}

struct Teams: Codable {
    let visitors, home: TeamsHome?
}

struct TeamsHome: Codable {
    let id: Int?
    let name, nickname, code: String?
    let logo: String?
}
