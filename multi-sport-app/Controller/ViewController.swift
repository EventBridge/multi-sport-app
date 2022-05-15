//
//  ViewController.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 14/5/2022.
//

import UIKit

class ViewController: UIViewController {

    var teams: [Team] = []
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Test fetch teams
        NetworkService.shared.fetchTeams { [weak self] (result) in
            switch result {
            case.success(let teams):
                self?.teams = teams
                print("The decoded data is: \(self?.teams)")
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
        
        // Test fetch players
        NetworkService.shared.fetchPlayers(team: "1", season: "2021") { [weak self] (result) in
            switch result {
            case.success(let players):
                self?.players = players
                print("The decoded data is: \(self?.players)")
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
    }


}

