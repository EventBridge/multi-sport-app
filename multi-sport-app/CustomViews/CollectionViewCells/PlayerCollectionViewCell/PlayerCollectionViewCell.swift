//
//  PlayerCollectionViewCell.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlayerCollectionViewCell"

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func setup(player: Player) {
        playerImageView.kf.setImage(with: URL(string: player.notAvailableImage))
        playerNameLabel.text = "\(player.firstname!) \(player.lastname!)"
        positionLabel.text = "Position: \(player.leagues?.standard?.pos ?? "none")"
        self.layer.cornerRadius = 20
    }
    


}
