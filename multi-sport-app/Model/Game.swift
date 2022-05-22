//
//  Game.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 19/5/2022.
//

import Foundation

struct Game: Codable {
    let id: Int?
    let league: String? //standard (actual nba, always standard)
    let season: Int? //2021
    let date: DateClass? //match date (start, end, duration)    "2022-05-23T01:00:00.000Z" showing american time
    let stage: Int? //4
    let status: Status? //(halftime, short, long) is it live?
    let periods: Periods? //(current, total, end of period)
    let arena: Arena? //(name, city, state, country)
    let teams: Teams? //(visitors, home)
    let scores: Scores? //(visitors, home)
    let officials: [String]? //judges who count the points
    let timesTied, leadChanges: Int? //2, 4
}

struct Arena: Codable { //from above
    let name, city, state, country: String?
}

struct DateClass: Codable {
    let start, end, duration: String? //from above
}

struct Periods: Codable { //from above
    let current, total: Int?
    let endOfPeriod: Bool?
}

struct Scores: Codable {
    let visitors, home: ScoresHome? //scores of two teams
}
//visitor a team, home another team

struct ScoresHome: Codable { //from score
    let win, loss: Int?
    let series: Series? //contains a win and loss scores
    let linescore: [String]? //scores for 1, 2, 3, 4
    let points: Int? //Total points
}

struct Series: Codable {
    let win, loss: Int? //from above
}

struct Status: Codable { //form above
    let halftime: Bool?
    let short: Int?
    let long: String?
}

struct Teams: Codable {
    let visitors, home: TeamsHome? //(id, name, nickname, code, logo))
}

struct TeamsHome: Codable { //from above
    let id: Int?
    let name, nickname, code: String?
    let logo: String?
}
