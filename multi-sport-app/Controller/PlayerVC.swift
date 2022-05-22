//
//  PlayerVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import ProgressHUD

class PlayerVC: UIViewController {
    
    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    var players: [Player] = []
    var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        
        teamCollectionView.layer.cornerRadius = 20
        
        registerCells()
        
        NetworkService.shared.fetchTeams() { [weak self] (result) in
            switch result {
            case.success(let teams):
                self?.teams = teams
                self?.cullTeams()
                self?.teamCollectionView.reloadData()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        ProgressHUD.show()
        // fetch players
        NetworkService.shared.fetchPlayers(team: "1", season: "2021") { [weak self] (result) in
            switch result {
            case.success(let players):
                self?.players = players
                self?.playerCollectionView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        
    }
    
    private func registerCells() {
        playerCollectionView.register(UINib(nibName: PlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier)
        teamCollectionView.register(UINib(nibName: TeamCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
    }
    
    private func cullTeams() {
        for (i, team) in teams.enumerated().reversed() {
            if team.nbaFranchise == false {
                teams.remove(at: i)
            }
        }
    }
}

extension PlayerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case playerCollectionView:
            return players.count
        case teamCollectionView:
            return teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case playerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier, for: indexPath) as! PlayerCollectionViewCell
            cell.setup(player: players[indexPath.row])
            return cell
        case teamCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
            cell.setup(team: teams[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == playerCollectionView {
            performSegue(withIdentifier: "goToPlayerDetail", sender: self)
        } else {
            updatePlayerCells(team: teams[indexPath.row])
        }
    }
    
    private func updatePlayerCells(team: Team) {
        ProgressHUD.show()
        // fetch players
        NetworkService.shared.fetchPlayers(team: String(team.id), season: "2021") { [weak self] (result) in
            switch result {
            case.success(let players):
                self?.players = players
                self?.playerCollectionView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? PlayerDetailVC
        if segue.identifier == "goToPlayerDetail" {
            destination?.player = players[(playerCollectionView.indexPathsForSelectedItems?.first?.row)!]
        }
    }
}

extension PlayerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 200)
    }
}

