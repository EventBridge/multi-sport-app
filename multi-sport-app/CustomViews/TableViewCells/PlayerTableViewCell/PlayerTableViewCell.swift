//
//  PlayerTableViewCell.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 21/5/2022.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    static let identifier = "PlayerTableViewCell"
    
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    
    
    func setup(player: Player) {
        playerImageView.kf.setImage(with: URL(string: player.notAvailableImage))
        playerNameLabel.text = "\(player.firstname ?? "No name") \(player.lastname ?? "No Name")"
        playerPositionLabel.text = "Position: \(player.leagues?.standard?.pos ?? "N/A")"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
