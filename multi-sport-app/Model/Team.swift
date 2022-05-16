//
//  Team.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

struct Team: Decodable {
    let id: Int
    let name, nickname, code, city: String
    let logo: String?
    let nbaFranchise: Bool
    
}
