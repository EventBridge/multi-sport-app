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
    let notAvailableImage = "https://previews.123rf.com/images/pe3check/pe3check1710/pe3check171000054/88673746-no-image-available-sign-internet-web-icon-to-indicate-the-absence-of-image-until-it-will-be-download.jpg?fj=1"
    
}
