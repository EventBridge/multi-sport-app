//
//  PlayerVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class PlayerVC: UIViewController {
    
    @IBOutlet weak var playerCollectionView: UICollectionView!
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
        //teamCollectionView.collectionViewLayout = UICollectionViewLayout()
        
        registerCells()
        
        // fetch players
        NetworkService.shared.fetchPlayers(team: "1", season: "2021") { [weak self] (result) in
            switch result {
            case.success(let players):
                self?.players = players
                self?.playerCollectionView.reloadData()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
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
}

extension PlayerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
}

