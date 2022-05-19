//
//  PlayerCollectionViewCell.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlayerCollectionViewCell"

    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func setup(player: Player) {
        playerNameLabel.text = player.firstname! + player.lastname!
        positionLabel.text = player.leagues?.standard?.pos ?? "No position found"
    }
    


}
