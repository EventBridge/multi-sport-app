//
//  Player.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 16/5/2022.
//

import Foundation

struct Player: Decodable {
    let id: Int?
    let firstname, lastname: String?
    let birth: Birth?
    let nba: Nba?
    let height: Height?
    let weight: Weight?
    let leagues: Leagues?
    var notAvailableImage = "https://previews.123rf.com/images/pe3check/pe3check1710/pe3check171000054/88673746-no-image-available-sign-internet-web-icon-to-indicate-the-absence-of-image-until-it-will-be-download.jpg?fj=1"
}


struct Birth: Codable {
    let date, country: String?
}

struct Height: Codable {
    let feets, inches, meters: String?
}

struct Leagues: Codable {
    let standard: Standard?
}

struct Standard: Codable {
    let jersey: Int?
    let active: Bool?
    let pos: String?
}

struct Nba: Codable {
    let start, pro: Int?
}

struct Weight: Codable {
    let pounds, kilograms: String?
}

