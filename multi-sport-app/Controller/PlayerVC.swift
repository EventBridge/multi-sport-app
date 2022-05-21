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
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
        //teamCollectionView.collectionViewLayout = UICollectionViewLayout()
        
        registerCells()
        
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
    }
}

extension PlayerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier, for: indexPath) as! PlayerCollectionViewCell
        cell.setup(player: players[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPlayerDetail", sender: self)
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

