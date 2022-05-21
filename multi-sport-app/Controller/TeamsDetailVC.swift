//
//  TeamsDetailVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher
import ProgressHUD

class TeamsDetailVC: UIViewController {
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamCityLabel: UILabel!
    @IBOutlet weak var playerTableView: UITableView!
    
    var team: Team?
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        teamImageView.kf.setImage(with: URL(string: team?.logo ?? "No Image"))
        teamNameLabel.text = team?.name ?? "No name found"
        teamCityLabel.text = team?.city ?? "No city found"
        
        playerTableView.layer.cornerRadius = 15.0
        
        registerCells()
        
        ProgressHUD.show()
        // fetch players
        NetworkService.shared.fetchPlayers(team: String(team?.id ?? 1), season: "2021") { [weak self] (result) in
            switch result {
            case.success(let players):
                self?.players = players
                self?.playerTableView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
    }
    
    private func registerCells() {
        playerTableView.register(UINib(nibName: PlayerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerTableViewCell.identifier)
    }
}

extension TeamsDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerTableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        cell.setup(player: players[indexPath.row])
        return cell
    }
    
}
